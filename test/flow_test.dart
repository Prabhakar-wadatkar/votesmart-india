import 'package:flutter_test/flutter_test.dart';
import 'package:votesmart_india/core/models/session_model.dart';
import 'package:votesmart_india/core/providers/session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:votesmart_india/core/services/session_service.dart';
import 'package:votesmart_india/core/services/firestore_service.dart';

class FakeSharedPreferences extends Fake implements SharedPreferences {
  final Map<String, dynamic> _data = {};

  @override
  String? getString(String key) => _data[key] as String?;
  
  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }
}

class FakeFirestoreService extends Fake implements FirestoreService {
  @override
  Future<void> saveSession(dynamic session) async {}
}

void main() {
  group('Integration Flow - Session and Journey', () {
    test('User should progress through journey steps correctly', () async {
      final fakePrefs = FakeSharedPreferences();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(fakePrefs),
          firestoreServiceProvider.overrideWithValue(FakeFirestoreService()),
        ],
      );
      addTearDown(container.dispose);

      // Initial state
      var session = container.read(sessionProvider);
      expect(session.completedSteps, 0);
      expect(session.progressPercent, 0.0);

      // Complete step 1
      container.read(sessionProvider.notifier).markStepComplete('eligibility');
      session = container.read(sessionProvider);
      expect(session.completedSteps, 1);
      expect(session.progress['eligibility'], true);

      // Complete all steps
      final steps = ['registration', 'verification', 'timeline', 'votingDay', 'results'];
      for (final step in steps) {
        container.read(sessionProvider.notifier).markStepComplete(step);
      }

      session = container.read(sessionProvider);
      expect(session.completedSteps, 6);
      expect(session.progressPercent, 1.0);
    });

    test('Session should handle user info updates and eligibility logic', () async {
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(FakeSharedPreferences()),
          firestoreServiceProvider.overrideWithValue(FakeFirestoreService()),
        ],
      );
      addTearDown(container.dispose);

      // Set age to 17
      container.read(sessionProvider.notifier).updateAge(17);
      var session = container.read(sessionProvider);
      expect(session.isEligible, false);
      expect(session.daysUntilEligible, isNotNull);

      // Set age to 18
      container.read(sessionProvider.notifier).updateAge(18);
      session = container.read(sessionProvider);
      expect(session.isEligible, true);
      expect(session.daysUntilEligible, isNull);

      // Set location
      container.read(sessionProvider.notifier).updateLocation('Mumbai');
      session = container.read(sessionProvider);
      expect(session.location, 'Mumbai');
    });

    test('Edge case: Multiple completions of the same step should not duplicate', () async {
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(FakeSharedPreferences()),
          firestoreServiceProvider.overrideWithValue(FakeFirestoreService()),
        ],
      );
      addTearDown(container.dispose);

      container.read(sessionProvider.notifier).markStepComplete('registration');
      container.read(sessionProvider.notifier).markStepComplete('registration');
      
      final session = container.read(sessionProvider);
      expect(session.completedSteps, 1);
    });
  });
}
