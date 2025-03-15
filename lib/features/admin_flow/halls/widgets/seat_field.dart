import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class SeatField extends StatelessWidget {
  final String label;
  final Color color;

  const SeatField({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
           SizedBox(height: 5.h),
          SizedBox(
            width: 50.w,height: 40.h,
            child: NewTextField(
            ),
          ),
        ],
      ),
    );
  }
}