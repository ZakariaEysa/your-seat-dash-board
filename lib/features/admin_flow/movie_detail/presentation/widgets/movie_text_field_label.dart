// movie_text_field_label.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class MovieTextFieldLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const MovieTextFieldLabel({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 5.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        NewTextField(
          controller: controller,
          keyboardType: TextInputType.text,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(
          //     RegExp(r'[a-zA-Z؀-ۿ\s]'),
          //   ),
          // ],
          borderColor: errorText != null ? Colors.red : Colors.black,
          errorText: errorText,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

