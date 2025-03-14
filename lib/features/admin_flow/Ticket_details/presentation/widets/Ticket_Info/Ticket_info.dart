import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'movie_info.dart';
import 'ticket_details.dart';

class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:50.w, right:80.w),
      child: Container(
        width:400.w,
        height: 450.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.black,
            width:0.3.w,
          ),
        ),
        child: Column(
          children: [
            const MovieInfo(),
            const TicketDetails(),
          ],
        ),
      ),
    );
  }
}