import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'formatters.dart';

class DateField extends StatelessWidget {
  final bool hasError;
  final Function(String) onChanged;

  const DateField({super.key, required this.hasError, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 45.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: hasError ? Colors.red : Colors.black,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 6.sp),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
              DateFormatter(),
            ],
            decoration: InputDecoration(
              hintText: 'Date',
              hintStyle: TextStyle(color: Colors.black, fontSize: 5.sp),
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              'Please enter the correct day, month and year.',
              style: TextStyle(color: Colors.red, fontSize: 3.sp),
            ),
          ),
      ],
    );
  }
}
