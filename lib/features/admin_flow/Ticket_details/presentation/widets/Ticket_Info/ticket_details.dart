import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top:30.h, left:10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/money.png",
                    width:5.w,
                    height: 20.h,
                    color: Colors.black,
                  ),
                 SizedBox(width:2.w),
                   Text(
                    "210.000 VND",
                    style: TextStyle(color: Colors.black, fontSize:4.sp),
                  )
                ],
              ),
              SizedBox(height:10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/location1.png",
                    width: 5.w,
                    height: 20.h,
                    color: Colors.black,
                  ),
                   SizedBox(width: 2.w),
                  Text(
                    "Vincom Ocean Park",
                    style: TextStyle(color: Colors.black, fontSize:4.sp),
                  ),
                   SizedBox(width:2.w),
                  Image.asset(
                    "assets/icons/cgv.png",
                    width:10.w,
                    height: 20.h,
                  ),
                ],
              ),
              SizedBox(height:2.h),
               Text(
                "4th floor, Vincom Ocean Park, Da Ton, Gia\nLam, Ha Noi",
                style: TextStyle(color: Colors.black, fontSize:4.sp),
              ),
              SizedBox(height:2.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/img_3.png",
                    width:5.w,
                    height: 20.h,
                    color: Colors.black,
                  ),
                  SizedBox(width:2.w),
                  Text(
                    "Show this QR code to the ticket counter to\nreceive your ticket",
                    style: TextStyle(color: Colors.black, fontSize:4.sp),
                  ),
                  SizedBox(width:2.w),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/qr.png",
                    width:40.w,
                    height: 128.h,
                  ),
                 SizedBox(width:2.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment  : paymed",
                        style: TextStyle(fontSize: 4.sp,color: Colors.black),
                      ),
                      SizedBox(height:2.h),
                      Text(
                        "Status   :   Active",
                        style: TextStyle(fontSize: 4.sp, color: Colors.black),
                      ),
                      SizedBox(height:2.h),
                      Row(
                        children: [
                        Text(
                            "Download ticket",
                            style: TextStyle
                              (fontSize: 4.sp,color: Colors.black),
                          ),
                          SizedBox(width:3.w),
                          Image.asset(
                            "assets/icons/dow.png",
                            width: 5.w,
                            height:20.h,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}