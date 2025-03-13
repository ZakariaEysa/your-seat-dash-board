import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextFiled extends StatelessWidget {
  final String? hinitText;
  final String? label;
  const TextFiled({super.key, this.hinitText, this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top:40.h, left:13.w,right: 12.w),
          child: Text(
            label!,
            style: TextStyle(
              fontSize:3.sp,
              color: Color(0XFF000000),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:5.h, left:10.w, right:60.w
          ),
          child: SizedBox(
            width: 180.w,
            height: 65.67.h,
            child: TextFormField(
              obscureText: false,
              style: TextStyle(fontSize:5.sp, color: Colors.black),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Color(0XFFEB68E3),
                    width:0.2.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0.r),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0XFFEB68E3)),
                ),
                hintText: hinitText,
                hintStyle: TextStyle(
                  color: Color(0xFF837D7D),
                  fontSize:3.sp,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
