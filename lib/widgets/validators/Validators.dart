class Validators {
  /// التحقق الأساسي من الحقول المطلوبة
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
      return '$fieldName cannot exceed $maxLength characters';
    }

    if (lettersOnly) {
      return _validateLettersOnly(value, fieldName, allowSpaces: allowSpaces);
    }

    if (numbersOnly) {
      return _validateNumbersOnly(value, fieldName);
    }

    return null;
  }


  /// للتحقق من أن المدخل أرقام فقط
  static String? _validateNumbersOnly(String value, String fieldName) {
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'contain numbers';
    }
    return null;
  }

  /// للتحقق من أن المدخل أحرف فقط
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

  /// للتحقق من البريد الإلكتروني
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

  /// للتحقق من كلمة المرور
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    return null;
  }

  /// للتحقق من رقم الهاتف
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
}