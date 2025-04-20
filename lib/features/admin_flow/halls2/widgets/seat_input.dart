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
    return Flexible(
      // استخدام Flexible بدلاً من Expanded
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 3.sp, // تقليل حجم الخط
            ),
          ),
          SizedBox(height: 2.h), // تقليل المسافة
          SizedBox(
          //  width: 90.w, // تقليل العرض
            child: NewTextField(
              controller: controller,
              borderColor: errorText != null ? Colors.red : Colors.black,
              errorText: errorText,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              contentPadding: EdgeInsets.all(4.sp), // تقليل padding للحقل
            ),
          ),
        ],
      ),
    );
  }
}
