import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          width: 0.8.sw, // ✅ 80% من عرض الشاشة
          height: 0.8.sh, // ✅ 80% من ارتفاع الشاشة
          padding: EdgeInsets.all(20.w), // ✅ تباعد متكيف مع الشاشة
          child: Center(
            child: Text(
              "Home Screen",
              style: TextStyle(color: Colors.black, fontSize: 20.sp),
            ),
          ),
        ),
      ),
    );
  }
}
