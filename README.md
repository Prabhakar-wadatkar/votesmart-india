# VoteSmart India — AI-Powered Election Assistant

**VoteSmart India** is an interactive, session-based Flutter Web PWA designed to educate Indian citizens on the election process. It provides personalized guidance, step-by-step registration journeys, and real-time election timelines using Gemini AI and Google Firebase.

## 🗳️ Chosen Vertical
**Election Process Education Assistant**

The solution addresses the complexity of the Indian electoral system by providing a "zero-login" assistant that helps users understand their eligibility, registration steps, and upcoming election schedules in their local language.

## 🚀 Key Features

- **Smart AI Assistant**: A context-aware chatbot powered by **Gemini 1.5 Flash**. It handles queries about voter eligibility, documents, and polling day procedures.
- **Dynamic Journey Tracker**: A personalized 6-step progress tracker that guides users from checking eligibility to casting their vote.
- **Regional Timelines**: A filtered view of upcoming elections (General, State, Local) across different Indian states.
- **Anonymous Session Management**: Uses a UUID-based session system to track progress and chat history without requiring a login, prioritizing user privacy and ease of access.
- **Multilingual Support**: Fully localized in **English (EN)**, **Hindi (HI)**, and **Marathi (MR)**.

## 🧠 Approach and Logic

### 1. Zero-Friction User Experience
To maximize accessibility, the app generates an anonymous `sessionId` (UUID v4) on the first visit. This session is persisted in `SharedPreferences` (local) and synced with **Firestore** (cloud), allowing users to resume their journey without the barrier of an authentication wall.

### 2. Context-Aware AI
When a user chats with the assistant, the app sends relevant context (age, location, language, and recent history) to a **Firebase Cloud Function**. This proxy:
- Sanitizes input to prevent XSS/Injection.
- Enforces rate limiting (30 req/min).
- Protects the Gemini API Key from client-side exposure.

### 3. State Management (Riverpod 3.0)
The app uses the latest **Riverpod 3.0 Notifier API** for a reactive, maintainable, and testable state architecture. This ensures that UI updates (like dark mode toggles or language switches) are instantaneous and robust.

### 4. Responsiveness & Premium Design
- **Desktop**: Uses a `NavigationRail` for wide screens.
- **Mobile**: Uses a `NavigationBar` and bottom-sheet-inspired layouts.
- **Aesthetics**: Implements "Glassmorphism" cards, vibrant Indian-inspired colors (Saffron, India Green, Navy Blue), and Material 3 design principles.

## 🛠️ Google Services Integration

- **Gemini API**: Core AI engine for conversational guidance.
- **Firebase Hosting**: High-performance PWA hosting with SSL.
- **Firebase Cloud Functions**: Secure proxy for AI interaction and backend logic.
- **Cloud Firestore**: Persistent storage for anonymous session data and chat history.
- **Firebase Analytics**: Anonymized usage tracking for service improvement.

## 🛡️ Security & Quality

- **Input Sanitization**: Multi-stage regex-based cleaning of all user inputs.
- **No-PII Policy**: No personal data (names, emails, phones) is requested or stored.
- **Unit Testing**: 21+ unit tests covering eligibility logic, serialization, and security utilities.
- **Accessibility**: Semantic HTML tags, high-contrast Material 3 theme, and scalable typography.

## 📋 How It Works (User Flow)

1. **Onboard**: User lands on the dashboard; a session is generated.
2. **Setup**: User optionally inputs their age and location for personalized election dates.
3. **Learn**: User explores the "Journey" or asks the AI assistant about specific forms (e.g., Form 6).
4. **Track**: User monitors the "Timeline" for upcoming polling dates in their region.
5. **Sync**: Progress is automatically saved, allowing the user to return later on the same browser.

## 🛠️ Installation & Deployment

1. **Clone & Install**:
   ```bash
   flutter pub get
   ```
2. **Configure Firebase**:
   - Create a Firebase project.
   - Update `lib/main.dart` with your `FirebaseOptions`.
3. **Deploy Functions**:
   ```bash
   firebase functions:config:set gemini.api_key="YOUR_KEY"
   firebase deploy --only functions
   ```
4. **Deploy Web**:
   ```bash
   flutter build web
   firebase deploy --only hosting
   ```

---
*Built as a submission for the Google Antigravity Challenge.*
