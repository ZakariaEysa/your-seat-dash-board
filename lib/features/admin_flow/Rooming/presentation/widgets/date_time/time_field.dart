import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'formatters.dart';

class TimeField extends StatelessWidget {
  final bool hasError;
  final Function(String) onChanged;

  const TimeField({super.key, required this.hasError, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9apmAPM]')),
              LengthLimitingTextInputFormatter(8),
              TimeFormatter(),
            ],
            decoration: InputDecoration(
              hintText: 'Time',
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
              'Please enter the correct hour and minute.',
              style: TextStyle(color: Colors.red, fontSize: 3.sp),
            ),
          ),
      ],
    );
  }
}
