import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Color borderColor;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? errorStyle;
  final TextAlign textAlign; // إضافة هذا السطر

  const NewTextField({
    Key? key,
    this.textAlign = TextAlign.left, // إضافة هذا السطر

    this.controller,
    this.hintText,
    this.obscureText = false,
    this.borderColor = Colors.grey,
    this.errorText,
    this.contentPadding,
    this.errorStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        errorText: errorText,
        errorStyle: errorStyle, // استخدام errorStyle هنا
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: contentPadding, // استخدام contentPadding هنا
      ),
    );
  }
}