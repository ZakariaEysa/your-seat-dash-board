import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/date.dart';
import '../widgets/room_Select.dart';

class Rooming extends StatelessWidget {
  const Rooming({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(child: RoomMovie()),
                    Flexible(child: DateTime()),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonBuilder(
                      text:'Add ',
                      onTap: () {},
                      width: 40.w,
                      height: 50.h,
                      buttonColor: Color(0xFF560B76),
                      borderShape: BorderRadius.circular(10.r),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:7.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ButtonBuilder(
                      text:'cancel',
                      onTap: () {},
                      width: 40.w,
                      height: 50.h,
                      buttonColor: Color(0xFF560B76),
                      borderShape: BorderRadius.circular(10.r),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:7.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
