import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/session_model.dart';

/// [SessionService] handles local persistence of user data using SharedPreferences.
/// It ensures that user progress and preferences are maintained across app restarts.
class SessionService {
  static const _sessionKey = 'votesmart_session_id';
  static const _ageKey = 'votesmart_age';
  static const _dobKey = 'votesmart_dob';
  static const _locationKey = 'votesmart_location';
  static const _regionKey = 'votesmart_region';
  static const _languageKey = 'votesmart_language';
  static const _progressPrefix = 'votesmart_progress_';
  static const _darkModeKey = 'votesmart_dark_mode';

  final SharedPreferences _prefs;

  /// Creates a [SessionService] with the provided [SharedPreferences] instance.
  SessionService(this._prefs);

  /// Get or create session ID
  String getOrCreateSessionId() {
    String? sessionId = _prefs.getString(_sessionKey);
    if (sessionId == null || sessionId.isEmpty) {
      sessionId = const Uuid().v4();
      _prefs.setString(_sessionKey, sessionId);
    }
    return sessionId;
  }

  /// Load session from local storage
  SessionModel loadSession() {
    final sessionId = getOrCreateSessionId();
    final age = _prefs.getInt(_ageKey);
    final dobStr = _prefs.getString(_dobKey);
    final location = _prefs.getString(_locationKey);
    final region = _prefs.getString(_regionKey);
    final language = _prefs.getString(_languageKey) ?? 'en';

    final progress = <String, bool>{};
    for (final step in [
      'eligibility',
      'registration',
      'verification',
      'timeline',
      'votingDay',
      'results'
    ]) {
      progress[step] = _prefs.getBool('$_progressPrefix$step') ?? false;
    }

    return SessionModel(
      sessionId: sessionId,
      age: age,
      dateOfBirth: dobStr != null ? DateTime.tryParse(dobStr) : null,
      location: location,
      region: region,
      progress: progress,
      language: language,
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    );
  }

  /// Save session data locally
  Future<void> saveSession(SessionModel session) async {
    if (session.age != null) await _prefs.setInt(_ageKey, session.age!);
    if (session.dateOfBirth != null) {
      await _prefs.setString(_dobKey, session.dateOfBirth!.toIso8601String());
    }
    if (session.location != null) {
      await _prefs.setString(_locationKey, session.location!);
    }
    if (session.region != null) {
      await _prefs.setString(_regionKey, session.region!);
    }
    await _prefs.setString(_languageKey, session.language);

    for (final entry in session.progress.entries) {
      await _prefs.setBool('$_progressPrefix${entry.key}', entry.value);
    }
  }

  /// Save dark mode preference
  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(_darkModeKey, isDark);
  }

  bool getDarkMode() => _prefs.getBool(_darkModeKey) ?? false;

  /// Save language preference
  Future<void> setLanguage(String lang) async {
    await _prefs.setString(_languageKey, lang);
  }

  String getLanguage() => _prefs.getString(_languageKey) ?? 'en';

  /// Clear all session data
  Future<void> clearSession() async {
    final keys = _prefs.getKeys().where((k) => k.startsWith('votesmart_'));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
}
