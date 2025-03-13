import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Text_filed.dart';
import '../widgets/country.dart';

class CinemaInfo extends StatelessWidget {
  const CinemaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: Container(
              width: 959.95.w,
              height: 668.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50.h, right: 100.w, left: 20.w),
                    child: Text(
                      "Public Info",
                      style: TextStyle(
                        fontSize: 6.sp,
                        color: Color(0XFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 100.w, left: 20.w),
                    child: Text(
                      "Update Your Cinema details here",
                      style: TextStyle(
                        fontSize: 5.sp,
                        color: Color(0XFF000000),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFiled(
                        label: "Cinema Name in English*",
                        hinitText: "musfiqmohammed123@gmail.com",
                      )),
                      Expanded(
                          child: TextFiled(
                        label: "Email Address*",
                        hinitText: "Musfiq  Mohammed",
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFiled(
                        label: "Phone Number*",
                        hinitText: "01025687431",
                      )),
                      Expanded(
                          child: TextFiled(
                        label: "Cinema Manager Name*",
                        hinitText: "Musfiq",
                      )),
                    ],
                  ),
                  SizedBox(height:40.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Cinema Address*",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,fontSize:4.sp),
                          ),
                          Country()
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/Map 1 (1).png",
                            width: 150.w,
                            height: 159.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "*Click here",
                                style: TextStyle(
                                    fontSize: 5.sp,
                                    color: Color(
                                      0XFF6F6F6F,
                                    )),
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
