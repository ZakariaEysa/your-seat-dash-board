import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/widgets/movietable.dart';

import '../../movie_detail/view/movie_details.dart';

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
                  width: 80,
                  height: 33,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF560B76),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MovieDetail()),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: MovieTablePage(),
            ),
          ],
        ),
      ),

    );
  }
}
