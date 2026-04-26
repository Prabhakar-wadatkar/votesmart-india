import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'core/providers/session_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Note: For production, replace these placeholders with your actual Firebase project config.
  // Or use 'flutterfire configure' to generate DefaultFirebaseOptions.
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyChfwaae9cvHxE4fTMGIIv-xHPsFdatggE',
          appId: '1:1038772084202:web:71600d2d15bb77030e2693',
          messagingSenderId: '1038772084202',
          projectId: 'votesmart-india-assistant',
          storageBucket: 'votesmart-india-assistant.firebasestorage.app',
        ),
      );
    }
  } catch (e) {
    debugPrint('Firebase initialization warning: $e');
    debugPrint('App will continue in limited offline mode.');
  }

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const VoteSmartApp(),
    ),
  );
}
