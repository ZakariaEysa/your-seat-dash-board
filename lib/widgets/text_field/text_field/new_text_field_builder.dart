import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Color borderColor;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? errorStyle;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines; // ✅ إضافة maxLines
  final bool isMultiline; // ✅ إضافة isMultiline

  const NewTextField({
    Key? key,
    this.textAlign = TextAlign.left,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.borderColor = Colors.grey,
    this.errorText,
    this.contentPadding,
    this.errorStyle,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.maxLines = 1, // تأكد من أن maxLines 1 إذا كانت isMultiline هي false
    this.isMultiline = false, // إذا كانت isMultiline صحيحة سنسمح بالكتابة على عدة أسطر
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
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
      errorStyle: errorStyle ?? TextStyle(fontSize: 12, color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );

    // إذا كانت isMultiline = true، استخدم maxLines مع TextFormField
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      textAlign: textAlign,
      keyboardType: isMultiline ? TextInputType.multiline : (keyboardType ?? TextInputType.text),
      maxLines: maxLines ?? (isMultiline ? 5 : 1), // ✅ تعديل هنا
      onChanged: onChanged,
      validator: validator,
      decoration: inputDecoration,
    );

  }
}