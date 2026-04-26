import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/session_model.dart';
import '../models/chat_message_model.dart';
import '../models/election_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ─── Sessions ───────────────────────────────────────────
  CollectionReference get _sessions => _firestore.collection('sessions');

  Future<void> saveSession(SessionModel session) async {
    try {
      await _sessions.doc(session.sessionId).set(
            session.toMap(),
            SetOptions(merge: true),
          );
    } catch (e) {
      // Silently fail - local storage is the primary source
      // Firestore is best-effort sync
    }
  }

  Future<SessionModel?> getSession(String sessionId) async {
    try {
      final doc = await _sessions.doc(sessionId).get();
      if (doc.exists) {
        return SessionModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }

  // ─── Chats ──────────────────────────────────────────────
  CollectionReference get _chats => _firestore.collection('chats');

  Future<void> saveChatMessages(
    String sessionId,
    List<ChatMessage> messages,
  ) async {
    try {
      await _chats.doc(sessionId).set({
        'sessionId': sessionId,
        'messages': messages.map((m) => m.toMap()).toList(),
        'lastMessageAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}
  }

  Future<List<ChatMessage>> getChatMessages(String sessionId) async {
    try {
      final doc = await _chats.doc(sessionId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final messages = (data['messages'] as List<dynamic>?) ?? [];
        return messages
            .map((m) => ChatMessage.fromMap(m as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  Future<void> clearChatHistory(String sessionId) async {
    try {
      await _chats.doc(sessionId).delete();
    } catch (_) {}
  }

  // ─── Elections ──────────────────────────────────────────
  CollectionReference get _elections => _firestore.collection('elections');

  Future<List<ElectionModel>> getElections({String? region}) async {
    try {
      Query query = _elections;
      if (region != null && region.isNotEmpty) {
        query = query.where('region', isEqualTo: region);
      }
      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) =>
              ElectionModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
