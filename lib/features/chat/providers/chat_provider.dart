import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../../core/models/chat_message_model.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/utils/input_sanitizer.dart';

/// Chat messages state
final chatMessagesProvider =
    NotifierProvider<ChatMessagesNotifier, List<ChatMessage>>(() {
  return ChatMessagesNotifier();
});

/// Chat loading state
final chatLoadingProvider = NotifierProvider<ChatLoadingNotifier, bool>(() {
  return ChatLoadingNotifier();
});

class ChatLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  
  set state(bool value) => super.state = value;
}

class ChatMessagesNotifier extends Notifier<List<ChatMessage>> {
  bool _loaded = false;

  @override
  List<ChatMessage> build() {
    return [];
  }

  Future<void> loadHistory() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      final session = ref.read(sessionProvider);
      final messages = await firestoreService.getChatMessages(session.sessionId);
      if (messages.isNotEmpty) {
        state = messages;
      }
    } catch (_) {}
  }

  Future<void> sendMessage(String content) async {
    final sanitized = InputSanitizer.sanitize(content);
    if (sanitized.isEmpty) return;

    // Add user message
    final userMessage = ChatMessage.user(sanitized);
    state = [...state, userMessage];

    // Set loading
    ref.read(chatLoadingProvider.notifier).state = true;

    try {
      // Build context from session
      final session = ref.read(sessionProvider);
      final context = <String, dynamic>{
        'sessionId': session.sessionId,
        'message': sanitized,
        'userAge': session.age,
        'userLocation': session.location,
        'language': session.language,
        'recentMessages': state
            .reversed
            .take(10)
            .map((m) => {'role': m.role, 'content': m.content})
            .toList()
            .reversed
            .toList(),
      };

      // Call Cloud Function
      String response;
      try {
        final callable =
            FirebaseFunctions.instance.httpsCallable('chatWithGemini');
        final result = await callable.call(context);
        response = result.data['response'] as String? ??
            'I apologize, I could not process your request.';
      } catch (e) {
        // Fallback: offline mock response
        response = _getOfflineResponse(sanitized, session.language);
      }

      // Add assistant message
      final assistantMessage = ChatMessage.assistant(response);
      state = [...state, assistantMessage];

      // Persist to Firestore (best effort)
      final firestoreService = ref.read(firestoreServiceProvider);
      firestoreService.saveChatMessages(session.sessionId, state);
    } catch (e) {
      final errorMessage = ChatMessage.assistant(
          'Sorry, something went wrong. Please try again.');
      state = [...state, errorMessage];
    } finally {
      ref.read(chatLoadingProvider.notifier).state = false;
    }
  }

  /// Offline response for when Cloud Functions are not available
  String _getOfflineResponse(String query, String language) {
    final q = query.toLowerCase();

    if (q.contains('eligible') || q.contains('age') || q.contains('पात्र') || q.contains('वय')) {
      return language == 'hi'
          ? 'भारतीय चुनावों में मतदान के लिए, आपकी आयु अर्हता तिथि (1 जनवरी, 1 अप्रैल, 1 जुलाई, या 1 अक्टूबर) पर कम से कम 18 वर्ष होनी चाहिए। आपको भारत का नागरिक होना चाहिए और उस निर्वाचन क्षेत्र का सामान्य निवासी होना चाहिए जहाँ आप नामांकित होना चाहते हैं।'
          : language == 'mr'
              ? 'भारतीय निवडणुकांमध्ये मतदान करण्यासाठी, तुमचे वय पात्रता तारखेला (1 जानेवारी, 1 एप्रिल, 1 जुलै किंवा 1 ऑक्टोबर) किमान 18 वर्षे असणे आवश्यक आहे.'
              : 'To vote in Indian elections, you must be at least 18 years old on the qualifying date (January 1, April 1, July 1, or October 1). You must be an Indian citizen and an ordinary resident of the constituency where you wish to be enrolled.\n\n**Qualifying Dates:**\n- January 1\n- April 1\n- July 1\n- October 1\n\nIf you are 17+, you can submit an advance application!';
    }

    if (q.contains('register') || q.contains('registration') || q.contains('पंजीकरण') || q.contains('नोंदणी')) {
      return language == 'hi'
          ? 'मतदाता के रूप में पंजीकरण करने के लिए:\n\n1. voters.eci.gov.in पर जाएँ\n2. फॉर्म 6 भरें\n3. आवश्यक दस्तावेज़ अपलोड करें\n4. सत्यापन की प्रतीक्षा करें\n\nआप वोटर हेल्पलाइन ऐप भी डाउनलोड कर सकते हैं।'
          : 'To register as a voter:\n\n1. **Online**: Visit [voters.eci.gov.in](https://voters.eci.gov.in) and fill **Form 6**\n2. **App**: Download the **Voter Helpline App**\n3. **Offline**: Visit your nearest ERO/BLO office\n\n**Documents needed:**\n- Proof of age (Birth certificate, Aadhaar, PAN card)\n- Proof of address (Aadhaar, utility bills)\n- Passport-size photograph\n\nAfter submission, a Booth Level Officer (BLO) will verify your details.';
    }

    if (q.contains('document') || q.contains('दस्तावेज') || q.contains('कागदपत्र')) {
      return 'For voter registration, you\'ll need:\n\n📋 **Proof of Age** (any one):\n- Birth Certificate\n- Aadhaar Card\n- PAN Card\n- Class X/XII Marksheet\n- Indian Passport\n\n🏠 **Proof of Address** (any one):\n- Aadhaar Card\n- Utility Bills\n- Bank Passbook\n- Rental Agreement\n\n📸 **Passport-size Photograph**\n\nFor corrections, use **Form 8**. For NRI registration, use **Form 6A**.';
    }

    if (q.contains('voting day') || q.contains('evm') || q.contains('मतदान')) {
      return 'On Voting Day:\n\n1. 🔍 **Find your booth** using the Voter Helpline App\n2. 🪪 **Carry your Voter ID** (EPIC) or any ECI-approved photo ID\n3. ✅ **Verification** — Officer checks your identity & applies ink\n4. 🗳️ **Cast your vote** — Press the button next to your candidate on the EVM\n5. 📄 **VVPAT Check** — Verify your vote on the paper slip\n6. 🚶 **Exit** the booth\n\n⏰ Polling hours: typically **7:00 AM to 6:00 PM**\n\nRemember: Campaigning stops 48 hours before polling!';
    }

    return language == 'hi'
        ? 'मैं वोटस्मार्ट इंडिया हूँ, आपका चुनाव शिक्षा सहायक। मैं आपको मतदाता पात्रता, पंजीकरण, मतदान प्रक्रिया, आवश्यक दस्तावेज़, और चुनाव कार्यक्रम के बारे में जानकारी दे सकता हूँ। कृपया अपना प्रश्न पूछें!'
        : language == 'mr'
            ? 'मी वोटस्मार्ट इंडिया आहे, तुमचा निवडणूक शिक्षण सहाय्यक. मी तुम्हाला मतदार पात्रता, नोंदणी, मतदान प्रक्रिया, आवश्यक कागदपत्रे आणि निवडणूक वेळापत्रकाबद्दल माहिती देऊ शकतो.'
            : 'I\'m **VoteSmart India**, your election education assistant! I can help you with:\n\n🗳️ **Voter Eligibility** — Check if you can vote\n📝 **Registration** — How to register as a voter\n📋 **Documents** — What documents you need\n📅 **Election Timeline** — Upcoming election dates\n🏛️ **Voting Process** — What happens on voting day\n📊 **Results** — How results are declared\n\nWhat would you like to know?';
  }

  void clearMessages() {
    state = [];
    _loaded = false;
  }
}
