import 'package:flutter_test/flutter_test.dart';
import 'package:votesmart_india/core/models/session_model.dart';

void main() {
  group('Eligibility Logic', () {
    test('age >= 18 should be eligible', () {
      final session = SessionModel.create('test-id').copyWith(age: 18);
      expect(session.isEligible, true);
    });

    test('age > 18 should be eligible', () {
      final session = SessionModel.create('test-id').copyWith(age: 25);
      expect(session.isEligible, true);
    });

    test('age < 18 should not be eligible', () {
      final session = SessionModel.create('test-id').copyWith(age: 17);
      expect(session.isEligible, false);
    });

    test('age = 0 should not be eligible', () {
      final session = SessionModel.create('test-id').copyWith(age: 0);
      expect(session.isEligible, false);
    });

    test('null age should not be eligible', () {
      final session = SessionModel.create('test-id');
      expect(session.isEligible, false);
    });

    test('days until eligible should be positive for minors', () {
      final dob = DateTime.now().subtract(const Duration(days: 365 * 16)); // 16 years old
      final session = SessionModel.create('test-id').copyWith(
        dateOfBirth: dob,
        age: 16,
      );
      expect(session.isEligible, false);
      expect(session.daysUntilEligible, isNotNull);
      expect(session.daysUntilEligible!, greaterThan(0));
    });

    test('days until eligible should be null for eligible users', () {
      final session = SessionModel.create('test-id').copyWith(age: 20);
      expect(session.daysUntilEligible, isNull);
    });

    test('exactly 18th birthday should be eligible', () {
      final session = SessionModel.create('test-id').copyWith(age: 18);
      expect(session.isEligible, true);
    });
  });

  group('Progress Tracking', () {
    test('new session should have 0 completed steps', () {
      final session = SessionModel.create('test-id');
      expect(session.completedSteps, 0);
      expect(session.totalSteps, 6);
      expect(session.progressPercent, 0.0);
    });

    test('marking steps should update progress', () {
      var session = SessionModel.create('test-id');
      final progress = Map<String, bool>.from(session.progress);
      progress['eligibility'] = true;
      progress['registration'] = true;
      session = session.copyWith(progress: progress);

      expect(session.completedSteps, 2);
      expect(session.progressPercent, closeTo(0.333, 0.01));
    });

    test('all steps complete should be 100%', () {
      var session = SessionModel.create('test-id');
      final progress = Map<String, bool>.from(session.progress);
      for (final key in progress.keys) {
        progress[key] = true;
      }
      session = session.copyWith(progress: progress);

      expect(session.completedSteps, 6);
      expect(session.progressPercent, 1.0);
    });
  });

  group('Session Serialization', () {
    test('toMap and fromMap should round-trip', () {
      final original = SessionModel.create('test-session-id').copyWith(
        age: 25,
        location: 'Mumbai',
        region: 'West',
        language: 'hi',
      );

      final map = original.toMap();
      final restored = SessionModel.fromMap(map);

      expect(restored.sessionId, original.sessionId);
      expect(restored.age, original.age);
      expect(restored.location, original.location);
      expect(restored.region, original.region);
      expect(restored.language, original.language);
    });

    test('fromMap should handle missing fields gracefully', () {
      final session = SessionModel.fromMap({'sessionId': 'abc'});
      expect(session.sessionId, 'abc');
      expect(session.age, isNull);
      expect(session.location, isNull);
      expect(session.language, 'en');
      expect(session.progress.length, 6);
    });
  });
}
