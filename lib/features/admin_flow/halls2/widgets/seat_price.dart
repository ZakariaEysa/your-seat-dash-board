
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_input.dart';

class SeatPriceSection extends StatelessWidget {
  final TextEditingController vipController;
  final TextEditingController premiumController;
  final TextEditingController standardController;
  final String? vipError;
  final String? premiumError;
  final String? standardError;

  const SeatPriceSection({
    required this.vipController,
    required this.premiumController,
    required this.standardController,
    this.vipError,
    this.premiumError,
    this.standardError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.circular(9.r)),
      padding: EdgeInsets.all(2.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price for seat", style: TextStyle(fontSize: 5.sp,color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: 3.h),
          Row(
            children: [
              SeatInput(label: 'VIP', color: Color(0xFFA79F06), controller: vipController, errorText: vipError),
              SizedBox(width: 8.w),
              SeatInput(label: 'Premium', color: Color(0xFFFF5E3A), controller: premiumController, errorText: premiumError),
              SizedBox(width: 8.w),
              SeatInput(label: 'Standard', color: Colors.blueAccent, controller: standardController, errorText: standardError),
              Column(
                children: [
                  IconButton(icon: Icon(Icons.add_circle_outline),color: Colors.black, onPressed: () {}),
                  IconButton(icon: Icon(Icons.edit, color: Colors.green), onPressed: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}