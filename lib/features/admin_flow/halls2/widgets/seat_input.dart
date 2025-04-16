import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class SeatInput extends StatelessWidget {
  final String label;
  final Color color;
  final TextEditingController? controller;
  final String? errorText;
  final Function(String)? onChanged;

  const SeatInput({
    required this.label,
    required this.color,
    this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 4.sp,
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 60.w,
            height: 34.h,
            child: NewTextField(
              controller: controller,
              borderColor: errorText != null ? Colors.red : Colors.black,
              errorText: errorText,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}