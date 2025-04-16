class Validators {
  static String? validateRequired(
      String? value,
      String fieldName, {
        int maxLength = 20,
      }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length > maxLength) {
      return 'Maximum $maxLength characters allowed';
    }
    return null;
  }
}
