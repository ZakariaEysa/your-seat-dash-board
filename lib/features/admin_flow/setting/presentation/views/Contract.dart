import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/button/button_builder.dart';

class Contract extends StatelessWidget {
  const Contract({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: Container(
              width: 300.w,
              height: 668.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 50.h, left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contract info",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp),
                    ),
                    Text(
                      "Update your Contract info here",
                      style:
                          TextStyle(color: Color(0xFF625C5C), fontSize: 5.sp),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonBuilder(
                          text: 'Download Contract',
                          onTap: () {},
                          width: 86.w,
                          height: 78.h,
                          buttonColor: const Color(0xFFF3F3F3),
                          frameColor: const Color(0xFFEB68E3),
                          borderShape: BorderRadius.circular(10.r),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        ),

                        SizedBox(
                          width: 40.w,
                        ),
                        ButtonBuilder(
                          text: 'Upload Contract',
                          onTap: () {},
                          width: 86.w,
                          height: 78.h,
                          buttonColor: const Color(0xFFF3F3F3),
                          frameColor: const Color(0xFFEB68E3),
                          borderShape: BorderRadius.circular(10.r),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonBuilder(
                            text: 'Save',
                            onTap: () {},
                            width: 45.w,
                            height: 60.h,
                            buttonColor: const Color(0xFF560B76),
                            frameColor: const Color(0xFF560B76),
                            borderShape: BorderRadius.circular(15.r),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          ButtonBuilder(
                            text: 'Cancel',
                            onTap: () {},
                            width: 45.w,
                            height: 60.h,
                            buttonColor: const Color(0xFFF3F3F3),
                            frameColor: Colors.black,
                            borderShape: BorderRadius.circular(15.r),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
