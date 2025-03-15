import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.only(left: 22.w, top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email : ",
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF6b307d),
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 340.w,
            height: 50.h,
            child: NewTextField(
              borderColor: Color(0xFFd7b6e1),
              hintText: "Example26@gmail.com",
            ),
          ),
          SizedBox(height: 25.h),
          Text(
            "Password :",
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF6b307d),
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 340.w,
            height: 50.h,
            child: NewTextField(
              borderColor: Color(0xFFd7b6e1),
              obscureText: true,
              hintText: "1234Aa?*",
            ),
          )
        ],
      ),
    );
  }
}
