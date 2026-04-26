import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {GoogleGenerativeAI} from "@google/generative-ai";

admin.initializeApp();
const db = admin.firestore();

// Rate limiting store (in-memory, resets on cold start)
const rateLimitMap = new Map<string, { count: number; resetTime: number }>();
const RATE_LIMIT = 30; // max requests per minute
const RATE_WINDOW = 60 * 1000; // 1 minute

// UUID v4 validation
function isValidUUID(id: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/.test(id);
}

// Sanitize input
function sanitize(input: string, maxLength = 1000): string {
  let clean = input.replace(/<[^>]*>/g, ""); // strip HTML
  clean = clean.trim();
  if (clean.length > maxLength) {
    clean = clean.substring(0, maxLength);
  }
  return clean;
}

// Rate limit check
function checkRateLimit(sessionId: string): boolean {
  const now = Date.now();
  const entry = rateLimitMap.get(sessionId);

  if (!entry || now > entry.resetTime) {
    rateLimitMap.set(sessionId, {count: 1, resetTime: now + RATE_WINDOW});
    return true;
  }

  if (entry.count >= RATE_LIMIT) {
    return false;
  }

  entry.count++;
  return true;
}

// System prompt for election education
const SYSTEM_PROMPT = `You are VoteSmart India, an AI assistant that educates Indian citizens about the election process. You provide accurate, helpful information about:
- Voter eligibility and registration (age >= 18, qualifying dates: Jan 1, Apr 1, Jul 1, Oct 1)
- Election timelines and important dates
- Required documents (Voter ID, Aadhaar, Form 6, etc.)
- Voting day procedures (EVM, VVPAT, polling booth process)
- Election results process
- Different types of elections (Lok Sabha, Vidhan Sabha, Local Body)

Important guidelines:
- Be concise, friendly, and factually accurate
- Reference official ECI guidelines when possible
- Provide step-by-step instructions when asked about processes
- Use markdown formatting for better readability
- If asked about specific candidates or political opinions, politely decline and stay neutral
- Respond in the user's preferred language when possible
- Include relevant links to official websites (voters.eci.gov.in, electoralsearch.eci.gov.in)`;

export const chatWithGemini = functions.https.onCall(async (request) => {
  const data = request.data;
  const sessionId = data.sessionId as string;
  const message = data.message as string;
  const userAge = data.userAge as number | undefined;
  const userLocation = data.userLocation as string | undefined;
  const language = data.language as string || "en";
  const recentMessages = data.recentMessages as Array<{role: string; content: string}> || [];

  // Validate sessionId
  if (!sessionId || !isValidUUID(sessionId)) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid session ID");
  }

  // Sanitize input
  const sanitizedMessage = sanitize(message);
  if (!sanitizedMessage) {
    throw new functions.https.HttpsError("invalid-argument", "Message cannot be empty");
  }

  // Rate limit
  if (!checkRateLimit(sessionId)) {
    throw new functions.https.HttpsError("resource-exhausted", "Rate limit exceeded. Please wait a moment.");
  }

  try {
    // Get API key from environment/params
    const apiKey = process.env.GEMINI_API_KEY ||
      (functions as any).config().gemini?.api_key || "";

    if (!apiKey) {
      throw new Error("Gemini API key not configured");
    }

    const genAI = new GoogleGenerativeAI(apiKey);
    const model = genAI.getGenerativeModel({model: "gemini-2.0-flash"});

    // Build context
    let contextInfo = `User language: ${language}`;
    if (userAge) contextInfo += `\nUser age: ${userAge}`;
    if (userLocation) contextInfo += `\nUser location: ${userLocation}`;

    // Build conversation history
    const history = recentMessages.map((m) => ({
      role: m.role === "user" ? "user" as const : "model" as const,
      parts: [{text: m.content}],
    }));

    const chat = model.startChat({
      history: history.length > 0 ? history.slice(0, -1) : [],
      systemInstruction: `${SYSTEM_PROMPT}\n\nUser context:\n${contextInfo}`,
    });

    const result = await chat.sendMessage(sanitizedMessage);
    const response = result.response.text();

    // Store in Firestore (best effort)
    try {
      const chatRef = db.collection("chats").doc(sessionId);
      await chatRef.set({
        sessionId,
        lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
        messages: admin.firestore.FieldValue.arrayUnion(
          {role: "user", content: sanitizedMessage, timestamp: new Date().toISOString()},
          {role: "assistant", content: response, timestamp: new Date().toISOString()}
        ),
      }, {merge: true});
    } catch (firestoreError) {
      console.warn("Failed to save chat to Firestore:", firestoreError);
    }

    return {response};
  } catch (error: any) {
    console.error("Gemini API error:", error);
    throw new functions.https.HttpsError("internal", "Failed to get AI response");
  }
});
