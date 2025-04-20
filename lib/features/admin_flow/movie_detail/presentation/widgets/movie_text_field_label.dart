import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class MovieTextFieldLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final TextStyle? hintStyle;
  final Color errorColor; // Added error color parameter

  const MovieTextFieldLabel({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.hintText = '',
    this.hintStyle,
    this.errorColor = Colors.red, // Default to red
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
          borderColor: errorText != null ? errorColor : Colors.black,
          errorText: errorText,
          errorColor: errorColor, // Pass error color to NewTextField
          onChanged: onChanged,
          hintText: hintText,
          hintStyle: hintStyle,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
        ),
      ],
    );
  }
}