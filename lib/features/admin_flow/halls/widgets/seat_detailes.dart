import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls/widgets/seat_field.dart';

class SeatDetails extends StatelessWidget {
  final String title;
  final Color textColor;

  const SeatDetails({required this.title, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold, color: Colors.black)),
         SizedBox(height: 5.h),
        Row(
          children:  [
            SeatField(label: 'VIP', color: Color(0xFFA79F06)),
            SizedBox(width: 8.w),
            SeatField(label: 'Premium', color: Color(0xFFFF5E3A)),
            SizedBox(width: 8.w),
            SeatField(label: 'Standard', color: Colors.blueAccent),
          ],
        ),
      ],
    );
  }
}