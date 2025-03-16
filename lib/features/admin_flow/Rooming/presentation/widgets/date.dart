import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimeFields extends StatefulWidget {
  const DateTimeFields({super.key});

  @override
  State<DateTimeFields> createState() => DateTimeFieldsState();
}

class DateTimeFieldsState extends State<DateTimeFields> {
  List<Map<String, String>> dateTimePairs = [];
  List<bool> dateErrors = [];
  List<bool> timeErrors = [];

  @override
  void initState() {
    super.initState();
    addDateTimePair();
  }

  bool validateDateTime() {
    bool isValid = true;
    setState(() {
      for (int i = 0; i < dateTimePairs.length; i++) {
        dateErrors[i] = dateTimePairs[i]['date'] == null ||
            dateTimePairs[i]['date']!.isEmpty;
        timeErrors[i] = dateTimePairs[i]['time'] == null ||
            dateTimePairs[i]['time']!.isEmpty;

        if (dateErrors[i] || timeErrors[i]) {
          isValid = false;
        }
      }
    });
    return isValid;
  }

  void addDateTimePair() {
    setState(() {
      dateTimePairs.add({"date": "", "time": ""});
      dateErrors.add(false);
      timeErrors.add(false);
    });
  }

  void removeDateTimePair(int index) {
    if (index != 0) {
      setState(() {
        dateTimePairs.removeAt(index);
        dateErrors.removeAt(index);
        timeErrors.removeAt(index);
      });
    }
  }

  Widget buildDateTimeRow(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom:15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 45.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: dateErrors[index] ? Colors.red : Colors.black),
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
              onChanged: (value) {
                setState(() {
                  dateTimePairs[index]['date'] = value;
                  dateErrors[index] = value.isEmpty;
                });
              },
            ),
          ),
          SizedBox(width: 4.w),


          Container(
            width: 45.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: timeErrors[index] ? Colors.red : Colors.black),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 6.sp),
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9APMapm:]')),
                LengthLimitingTextInputFormatter(8),
                TimeFormatter(),
              ],
              decoration: InputDecoration(
                hintText: 'Time',
                hintStyle: TextStyle(color: Colors.black, fontSize: 5.sp),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  dateTimePairs[index]['time'] = value;
                  timeErrors[index] = value.isEmpty;
                });
              },
            ),
          ),

          if (index != 0)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red, size: 6.w),
              onPressed: () => removeDateTimePair(index),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80.h),
      child: Column(
        children: [
          ...dateTimePairs.asMap().entries.map((entry) {
            return buildDateTimeRow(entry.key);
          }).toList(),
          SizedBox(height: 20.h),
          IconButton(
            icon:
            Icon(Icons.add_circle_outline, color: Colors.black, size: 8.w),
            onPressed: addDateTimePair,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('/', '');
    if (text.length > 2 && text.length <= 4) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length > 4) {
      text =
      '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4, 8)}';
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(':', '').toUpperCase();

    if (text.length > 2 && text.length <= 4) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
    }

    if (text.length >= 5 && text.length <= 7) {
      if (text.endsWith("A") || text.endsWith("P")) {
        text += "M";
      }
    }
    if (text.length == 8 &&
        !(text.endsWith("AM") || text.endsWith("PM"))) {
      text = text.substring(0, 5);
    }

    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
