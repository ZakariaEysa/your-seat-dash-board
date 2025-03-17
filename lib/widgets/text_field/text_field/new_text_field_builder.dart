import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewTextField extends StatelessWidget {
  final bool? obscureText; // جعله اختياريًا
  final String? hintText; // جعله اختياريًا
  final Color borderColor;
  TextEditingController? controller = TextEditingController();
   NewTextField({
    super.key,
      this.controller,
    this.obscureText,
    this.hintText,
    this.borderColor=Colors.black, // borderColor مطلوب دائمًا
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false, // إذا كان null، استخدم false كقيمة افتراضية
      style: TextStyle(fontSize: 5.sp, color: Colors.black),
      textAlign: TextAlign.start,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText, // hintText اختياري
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: borderColor, // لون البورد من المتغير
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0.r),
          borderSide: BorderSide(
            width: 1,
            color: borderColor, // لون البورد من المتغير
          ),
        ),
      ),
    );
  }
}