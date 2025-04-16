import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/button/button_builder.dart';

class MovieImageSection extends StatelessWidget {
  const MovieImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/avatar_film.png",
          width: 50.w,
          height: 130.h,
        ),
        SizedBox(height: 25.h),
        Row(
          children: [
            SizedBox(width: 5.w),
            ButtonBuilder(
              text: 'Upload',
              onTap: () {},
              width: 30.w,
              height: 51.h,
              buttonColor: const Color(0xFF560B76),
              frameColor: const Color(0xFF560B76),
              borderShape: BorderRadius.circular(15.r),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 6.sp,
              ),
            ),
            SizedBox(width: 2.w),
            TextButton(
              onPressed: () {},
              child: Text(
                'Delete',
                style: TextStyle(
                  color: const Color(0xFFFF0000),
                  fontSize: 4.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
