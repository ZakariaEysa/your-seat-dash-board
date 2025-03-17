// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/widgets/movie_info.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/widgets/names.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/widgets/story_line.dart';
// import 'package:yourseatgraduationproject/widgets/list/list.dart';
// import '../../../../widgets/button/button_builder.dart';
// import '../widgets/story_line.dart';
// class MovieDetail extends StatelessWidget {
//   const MovieDetail({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Row(
//         children: [
//           // Navigation List (بدون تغيير)
//          // NavigationList(),
//
//           // المحتوى الرئيسي
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // MovieInfoScreen
//                     MovieInfoScreen(),
//                     SizedBox(height: 20.h),
//
//                     // Names
//                     Names(),
//                     SizedBox(height: 20.h),
//
//                     // StoryLine
//                      Text(
//                       'StoryLine',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 6.sp,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     StoryLine(),
//                     SizedBox(height: 5.h),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ButtonBuilder(
//                           text: 'Add Movie',
//                           onTap: () {},
//                           width: 100.w,
//                           height: 40.h,
//                           buttonColor: Color(0xFF560B76),
//                           borderShape: BorderRadius.circular(10.r),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                           ),
//                         ),
//                         SizedBox(width: 20.w),
//                         ButtonBuilder(
//                           text: 'Cancel',
//                           onTap: () {},
//                           width: 100.w,
//                           height: 40.h,
//                           buttonColor: Color(0xFF560B76),
//                           borderShape: BorderRadius.circular(10.r),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                    // SizedBox(height: 20.h),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/widgets/movie_info.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/widgets/names.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/widgets/story_line.dart';
import '../../../../widgets/button/button_builder.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 30.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: MovieInfoScreen(),
            ),

            Padding(
              padding:  EdgeInsets.only(left: 100.w,top:30.h,bottom: 10.h),
              child: Text(
                "Story Line",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 6.sp),
              ),
            ),

            StoryLine(),
            // SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.all(48.sp),
              child: Names(),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
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
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
