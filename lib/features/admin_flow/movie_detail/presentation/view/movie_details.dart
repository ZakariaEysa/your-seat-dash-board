import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/movie_info.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/story_line.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/story_line.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: MovieInfoScreen(),
          ),
          SizedBox(height: 10.h),

          SizedBox(height: 4.h),
          Expanded(
              flex: 1,
              child: StoryLine()
            //StoryLine(),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBuilder(
                  text: 'Add Movie',
                  onTap: () {},
                  width: 40.w,
                  height: 50.h,
                  buttonColor: Color(0xFF560B76),
                  borderShape: BorderRadius.circular(10.r),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                ButtonBuilder(
                  text: 'cancel',
                  onTap: () {},
                  width: 40.w,
                  height: 50.h,
                  buttonColor: Color(0xFF560B76),
                  borderShape: BorderRadius.circular(10.r),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}