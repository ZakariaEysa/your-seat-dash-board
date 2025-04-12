import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ColorRingWidget.dart';
import 'booking_Item.dart';

class BookingStates extends StatelessWidget {
  const BookingStates({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.w,
        height: 270.h,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Booking States",
                style: TextStyle(
                  fontSize: 5.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ColorRingWidget(),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Item(
                          percentage: "92%",
                          color: Color(0xFF7F33CC),
                          label: "Total Booking",
                        ),
                        Item(
                          percentage: "33.4%",
                          color: Color(0xFFC69CFF),
                          label: "Active States",
                        ),
                        Item(
                          percentage: "  58.6%",
                          color: Color(0xFFE4C4FF),
                          label: "Used States",
                        ),
                        Item(
                          percentage: "8%",
                          color: Color(0xFF490073),
                          label: "Cancel States",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
