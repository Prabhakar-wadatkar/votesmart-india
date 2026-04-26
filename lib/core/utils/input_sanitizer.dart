/// Sanitizes user input to prevent injection attacks
class InputSanitizer {
  /// Remove HTML tags and limit length
  static String sanitize(String input, {int maxLength = 1000}) {
    // Remove script tags and their content first
    String sanitized = input.replaceAll(
        RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false, dotAll: true), '');
    // Remove other HTML tags
    sanitized = sanitized.replaceAll(RegExp(r'<[^>]*>'), '');
    // Trim whitespace
    sanitized = sanitized.trim();
    // Limit length
    if (sanitized.length > maxLength) {
      sanitized = sanitized.substring(0, maxLength);
    }
    return sanitized;
  }

  /// Validate that a string looks like a UUID v4
  static bool isValidUUID(String input) {
    return RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$')
        .hasMatch(input);
  }
}
