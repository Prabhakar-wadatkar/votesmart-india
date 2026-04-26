import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/session_service.dart';
import '../services/firestore_service.dart';
import '../models/session_model.dart';

/// SharedPreferences instance provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

/// Session service provider
final sessionServiceProvider = Provider<SessionService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SessionService(prefs);
});

/// Firestore service provider
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

/// Session state provider
final sessionProvider = NotifierProvider<SessionNotifier, SessionModel>(() {
  return SessionNotifier();
});

class SessionNotifier extends Notifier<SessionModel> {
  @override
  SessionModel build() {
    final sessionService = ref.watch(sessionServiceProvider);
    final firestoreService = ref.watch(firestoreServiceProvider);
    
    final currentSession = sessionService.loadSession();
    // Best-effort Firestore sync
    firestoreService.saveSession(currentSession);
    
    return currentSession;
  }

  Future<void> updateAge(int age) async {
    final sessionService = ref.read(sessionServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    
    state = state.copyWith(age: age);
    await sessionService.saveSession(state);
    firestoreService.saveSession(state);
  }

  Future<void> updateDateOfBirth(DateTime dob) async {
    final sessionService = ref.read(sessionServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    
    final age = DateTime.now().difference(dob).inDays ~/ 365;
    state = state.copyWith(dateOfBirth: dob, age: age);
    await sessionService.saveSession(state);
    firestoreService.saveSession(state);
  }

  Future<void> updateLocation(String location, {String? region}) async {
    final sessionService = ref.read(sessionServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    
    state = state.copyWith(location: location, region: region);
    await sessionService.saveSession(state);
    firestoreService.saveSession(state);
  }

  Future<void> updateLanguage(String language) async {
    final sessionService = ref.read(sessionServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    
    state = state.copyWith(language: language);
    await sessionService.saveSession(state);
    firestoreService.saveSession(state);
  }

  Future<void> markStepComplete(String step) async {
    final sessionService = ref.read(sessionServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    
    final progress = Map<String, bool>.from(state.progress);
    progress[step] = true;
    state = state.copyWith(progress: progress);
    await sessionService.saveSession(state);
    firestoreService.saveSession(state);
  }

  Future<void> clearSession() async {
    final sessionService = ref.read(sessionServiceProvider);
    await sessionService.clearSession();
    state = sessionService.loadSession();
  }
}

/// Dark mode provider
final darkModeProvider = NotifierProvider<DarkModeNotifier, bool>(() {
  return DarkModeNotifier();
});

class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    final sessionService = ref.watch(sessionServiceProvider);
    return sessionService.getDarkMode();
  }

  Future<void> toggle() async {
    final sessionService = ref.read(sessionServiceProvider);
    state = !state;
    await sessionService.setDarkMode(state);
  }
}

/// Locale provider
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final sessionService = ref.watch(sessionServiceProvider);
    final lang = sessionService.getLanguage();
    return Locale(lang);
  }

  Future<void> setLocale(String languageCode) async {
    final sessionService = ref.read(sessionServiceProvider);
    state = Locale(languageCode);
    await sessionService.setLanguage(languageCode);
  }
}
