import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/button/button_builder.dart';

class CinemaDesign extends StatelessWidget {
  const CinemaDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(12.0.sp),
              child: Container(
                  width: 850.95.w,
                  height: 668.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 40.h, left: 10.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "update Cinema Tax Register here",
                              style: TextStyle(
                                  color: Color(0xFF6A6767), fontSize: 5.sp),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex:10,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "upload PDF",
                                            style: TextStyle(
                                                color: Color(0xFF6A6767),
                                                fontSize: 5.sp),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Image.asset(
                                            "assets/icons/download 1 (1).png",
                                            width: 50.w,
                                            height: 130.h,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            "*PDF maximum 10 MB .",
                                            style: TextStyle(
                                                color: Color(0xFF6A6767),
                                                fontSize:3.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 2.w,),
                                      Row(
                                        children: [
                                          ButtonBuilder(
                                            text: 'Upload',
                                            onTap: () {},
                                            width: 30.w,
                                            height: 51.h,
                                            buttonColor: Color(0xFF292D32),
                                            frameColor: Color(0xFF560B76),
                                            borderShape:
                                                BorderRadius.circular(15.r),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 5.sp,
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),

                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                    fontSize:4.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "upload cover",
                                          style: TextStyle(
                                              color: Color(0xFF6A6767),
                                              fontSize: 5.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Image.asset(
                                          "assets/icons/cinema.png",
                                          width:65.w,
                                          height: 130.84.h,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "*Cover size (342×120) pixels , maximum 1 MB  .",
                                          style: TextStyle(
                                              color: Color(0xFF6A6767),
                                              fontSize:3.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ButtonBuilder(
                                          text: 'Upload',
                                          onTap: () {},
                                          width: 30.w,
                                          height: 51.h,
                                          buttonColor: Color(0xFF292D32),
                                          frameColor: Color(0xFF560B76),
                                          borderShape:
                                              BorderRadius.circular(15.r),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 5.sp,
                                          ),
                                        ),
                                        SizedBox(width: 1.w),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:4.sp
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
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
                                    buttonColor: Color(0xFF292D32),
                                    frameColor: Colors.black,
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
                                    buttonColor: Color(0xFFF3F3F3),
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
                          ]))))),
    );
  }
}
