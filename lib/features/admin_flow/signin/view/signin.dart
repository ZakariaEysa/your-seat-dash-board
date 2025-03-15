import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/button/button_builder.dart';
import '../widgets/log_in.dart';
class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFF560b76),
              child: Center(
                child: Image.asset('assets/images/sign_in.png', height: 300),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50.w, top: 50.h),
                      child: Text(
                        "sign in",
                        style: TextStyle(
                          //fontFamily: "Potta One",
                          fontSize: 14.sp,
                          color: const Color(0xFF6b307d),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    LogIn(),
                    SizedBox(height: 30.h,),

                    ButtonBuilder(
                      text: 'Sign In',
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
            ),
          ),
        ],
      ),
    );
  }
}
