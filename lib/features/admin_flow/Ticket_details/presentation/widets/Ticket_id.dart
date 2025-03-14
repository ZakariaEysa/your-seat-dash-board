import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/button/button_builder.dart';

class TicketId extends StatelessWidget {
  const TicketId({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:50.w, right:80.w),
      child: Container(
        width:600.w,
        height: 169.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.black,
            width:0.3.w,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.all(2.0.sp),
                  child: Text(
                    "Enter order ID ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:5.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width:100.w,
                  height: 120.h,
                  child: Padding(
                    padding:  EdgeInsets.only(
                      top: 15.h,
                      right: 20.w,
                      left:10.w,
                    ),
                    child: TextFormField(
                      obscureText: false,
                      style: TextStyle(fontSize:4.sp, color: Colors.black),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFDBD9D9),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0.r),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width:20.w),
            ButtonBuilder(
              text:'Ticket',
              onTap: () {},
              width:40.w,
              height: 50.h,
              buttonColor: Color(0xFF560B76),
              frameColor: Colors.black,
              borderShape: BorderRadius.circular(10.r),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize:6.sp,
              ),
            ),

          ],
        ),
      ),
    );
  }
}