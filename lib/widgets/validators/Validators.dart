class Validators {
  /// Basic validation for required fields
  static String? validateRequired(
      String? value,
      String fieldName, {
        int maxLength = 20,
        int minLength = 1,
        bool lettersOnly = false,
        bool numbersOnly = false,
        bool allowSpaces = true,
      }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return '$fieldName at most $maxLength characters';
    }

    if (lettersOnly) {
      return _validateLettersOnly(value, fieldName, allowSpaces: allowSpaces);
    }

    if (numbersOnly) {
      return _validateNumbersOnly(value, fieldName);
    }

    return null;
  }

  /// Validate numbers only
  static String? _validateNumbersOnly(String value, String fieldName) {
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return '$fieldName must contain numbers only';
    }
    return null;
  }

  /// Validate letters only
  static String? _validateLettersOnly(
      String value,
      String fieldName, {
        bool allowSpaces = true,
      }) {
    final pattern = allowSpaces ? r'^[a-zA-Z\u0600-\u06FF\s]+$' : r'^[a-zA-Z\u0600-\u06FF]+$';
    final lettersRegex = RegExp(pattern);

    if (!lettersRegex.hasMatch(value)) {
      return '$fieldName must contain letters only${allowSpaces ? '' : ' (no spaces allowed)'}';
    }
    return null;
  }

  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    return null;
  }

  /// Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validate YouTube URL
  static String? validateYouTubeLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'YouTube link is required';
    }

    final youtubeRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$',
      caseSensitive: false,
    );

    if (!youtubeRegex.hasMatch(value)) {
      return 'Please enter a valid YouTube URL';
    }

    return null;
  }
}