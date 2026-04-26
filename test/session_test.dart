import 'package:flutter_test/flutter_test.dart';
import 'package:votesmart_india/core/utils/input_sanitizer.dart';

void main() {
  group('Input Sanitizer', () {
    test('should remove HTML tags', () {
      expect(
        InputSanitizer.sanitize('<script>alert("xss")</script>Hello'),
        'Hello',
      );
    });

    test('should trim whitespace', () {
      expect(InputSanitizer.sanitize('  hello world  '), 'hello world');
    });

    test('should limit length', () {
      final longInput = 'a' * 2000;
      expect(InputSanitizer.sanitize(longInput).length, 1000);
    });

    test('should handle empty input', () {
      expect(InputSanitizer.sanitize(''), '');
    });

    test('should preserve normal text', () {
      expect(
        InputSanitizer.sanitize('How do I register as a voter?'),
        'How do I register as a voter?',
      );
    });
  });

  group('UUID Validation', () {
    test('should accept valid UUID v4', () {
      expect(
        InputSanitizer.isValidUUID('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'),
        true,
      );
    });

    test('should reject invalid UUID', () {
      expect(InputSanitizer.isValidUUID('not-a-uuid'), false);
      expect(InputSanitizer.isValidUUID(''), false);
      expect(InputSanitizer.isValidUUID('12345'), false);
    });

    test('should reject UUID v1 (not v4)', () {
      // UUID v1 has version 1 in position 13
      expect(
        InputSanitizer.isValidUUID('a1b2c3d4-e5f6-1a7b-8c9d-0e1f2a3b4c5d'),
        false,
      );
    });
  });
}
