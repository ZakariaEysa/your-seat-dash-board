import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTime extends StatefulWidget {
  const DateTime({super.key});

  @override
  State<DateTime> createState() => _DateTimeFieldsState();
}

class _DateTimeFieldsState extends State<DateTime> {
  List<Widget> dateFields = [];
  List<Widget> timeFields = [];

  @override
  void initState() {
    super.initState();
    dateFields.add(buildDateField());
    timeFields.add(buildTimeField());
  }

  Widget buildDateField() {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Container(
        width: 40.w,
        height: 51.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 5.sp),
          decoration: InputDecoration(
            hintText: 'Date',
            hintStyle: TextStyle(color: Colors.black, fontSize: 5.sp),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          ),
        ),
      ),
    );
  }

  Widget buildTimeField() {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Container(
        width: 40.w,
        height: 51.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize:5.sp),
          decoration: InputDecoration(
            hintText: 'Time',
            hintStyle: TextStyle(color: Colors.black, fontSize: 5.sp),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                ...dateFields,
                SizedBox(height: 20.h),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      dateFields.add(buildDateField());
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              children: [
                ...timeFields,
                SizedBox(height: 20.h),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      timeFields.add(buildTimeField());
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}