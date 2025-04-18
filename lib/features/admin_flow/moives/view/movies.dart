import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/widgets/movietable.dart';

import '../../movie_detail/presentation/view/movie_details.dart';

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top:15.h,left:270.w),
              child: SizedBox(
                width: 32.w,
                height: 44.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF560B76),
                    padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.w),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MovieDetail()),
                    );
                  },
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.white, size: 7.sp),
                      SizedBox(width: 3.w),
                      Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 5.sp)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.only(left: 10.w),
                child: MovieTablePage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}