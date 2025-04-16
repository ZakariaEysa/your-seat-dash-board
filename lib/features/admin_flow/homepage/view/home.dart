import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/MoviStates.dart';
import '../widgets/booking_states.dart';
import '../widgets/sales-overview.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/musfiq.png",
                      width: 20.w, height: 95.h, fit: BoxFit.cover),
                  SizedBox(
                    width: 4.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Musfiq",
                        style:
                            TextStyle(fontSize: 5.sp, color: Color(0xFF151D48)),
                      ),
                      Text("Admin",
                          style: TextStyle(
                            fontSize: 4.sp,
                            color: Colors.black,
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              SalesOverview(),
              SizedBox(height: 30.h),
              BookingStates(),
              SizedBox(height: 30.h),
              MovieStates(),
            ],
          ),
        ),
      ),
    );
  }
}
