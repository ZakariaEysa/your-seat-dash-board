import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 40.h, left: 10.w),
          child: Image.asset(
            "assets/images/Rectangle 21.png",
            width:75.w,
            height: 173.h,
          ),
        ),
         SizedBox(width:10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 40.h),
            Text(
              "Avengers: Infinity War",
              style: TextStyle(
                color: Colors.black,
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icons/clock_icon.png",
                  width:5.w,
                  height: 20.h,
                  color: Colors.black,
                ),
                SizedBox(width:2.w),
                 Text(
                  "2 hours 29 minutes",
                  style: TextStyle(color: Colors.black, fontSize:4.sp),
                )
              ],
            ),
             SizedBox(height: 5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/video.png",
                  width:5.w,
                  height: 20.h,
                  color: Colors.black,
                ),
                SizedBox(width:2.w),
                 Text(
                  "Action, adventure, sci-fi",
                  style: TextStyle(color: Colors.black, fontSize:4.sp),
                )
              ],
            ),
            SizedBox(height:15.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/calendar.png",
                      width:10.w,
                      height:48.h,
                      color: Colors.black,
                    ),
                    SizedBox(width:2.w),
                     Text(
                      "14h15 \n 10.12.2022",
                      style: TextStyle(color: Colors.black, fontSize: 4.sp),
                    )
                  ],
                ),
                 SizedBox(width:10.w),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/vYzyIu_2_.png",
                      width:10.w,
                      height: 48.h,
                      color: Colors.black,
                    ),
                     SizedBox(width:2.w),
                     Text(
                      "seat F10 \n Section 4",
                      style: TextStyle(color: Colors.black, fontSize: 4.sp),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}