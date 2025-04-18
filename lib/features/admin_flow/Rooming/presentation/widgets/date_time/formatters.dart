import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('/', '');
    if (text.length > 2 && text.length <= 4) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length > 4) {
      text = '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4, 8)}';
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.toUpperCase();
    text = text.replaceAll(RegExp(r'[^0-9APM:]'), '');
    text = text.replaceAll(':', '');

    if (text.length > 4) {
      final hour = text.substring(0, 2);
      final minute = text.substring(2, 4);
      String suffix = text.substring(4);
      if (suffix.length > 2) {
        suffix = suffix.substring(0, 2);
      }
      text = '$hour:$minute$suffix';
    } else if (text.length > 2) {
      final hour = text.substring(0, 2);
      final minute = text.substring(2);
      text = '$hour:$minute';
    }

    if (text.length > 7) {
      text = text.substring(0, 7);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
