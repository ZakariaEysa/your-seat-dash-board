import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'date_field.dart';
import 'time_field.dart';

class DateTimeFields extends StatefulWidget {
  const DateTimeFields({super.key});

  @override
  State<DateTimeFields> createState() => DateTimeFieldsState();
}

class DateTimeFieldsState extends State<DateTimeFields> {
  List<Map<String, String>> dateTimePairs = [];
  List<Map<String, String>> savedDateTimePairs = [];
  List<bool> dateErrors = [];
  List<bool> timeErrors = [];

  @override
  void initState() {
    super.initState();
    addDateTimePair();
    savedDateTimePairs = List.from(dateTimePairs);
  }

  void resetToSaved() {
    setState(() {
      dateTimePairs = List.from(savedDateTimePairs);
      dateErrors = List.filled(dateTimePairs.length, false);
      timeErrors = List.filled(dateTimePairs.length, false);
    });
  }

  void saveCurrent() {
    savedDateTimePairs = List.from(dateTimePairs);
  }

  bool validateDateTime() {
    bool isValid = true;
    DateTime today = DateTime.now();

    setState(() {
      for (int i = 0; i < dateTimePairs.length; i++) {
        String? dateStr = dateTimePairs[i]['date'];
        String? timeStr = dateTimePairs[i]['time'];

        dateErrors[i] = dateStr == null || dateStr.isEmpty;
        timeErrors[i] = timeStr == null || timeStr.isEmpty;

        if (!dateErrors[i]) {
          try {
            final parts = dateStr!.split('/');
            if (parts.length == 3) {
              final day = int.parse(parts[0]);
              final month = int.parse(parts[1]);
              final year = int.parse(parts[2]);

              if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1000) {
                dateErrors[i] = true;
                isValid = false;
                continue;
              }

              final inputDate = DateTime(year, month, day);
              if (inputDate.isBefore(DateTime(today.year, today.month, today.day))) {
                dateErrors[i] = true;
                isValid = false;
              }
            } else {
              dateErrors[i] = true;
              isValid = false;
            }
          } catch (_) {
            dateErrors[i] = true;
            isValid = false;
          }
        }

        if (!timeErrors[i]) {
          try {
            final timeRegex = RegExp(r'^(\d{2}):(\d{2})(AM|PM)$', caseSensitive: false);
            final match = timeRegex.firstMatch(timeStr!.toUpperCase());

            if (match != null) {
              int hour = int.parse(match.group(1)!);
              int minute = int.parse(match.group(2)!);

              if (hour < 1 || hour > 12 || minute < 0 || minute > 59) {
                timeErrors[i] = true;
                isValid = false;
              }
            } else {
              timeErrors[i] = true;
              isValid = false;
            }
          } catch (_) {
            timeErrors[i] = true;
            isValid = false;
          }
        }

        if (dateErrors[i] || timeErrors[i]) {
          isValid = false;
        }
      }

      // ✅ التحقق من التكرار بعد التحقق من الصلاحية
      final seen = <String>{};
      for (int i = 0; i < dateTimePairs.length; i++) {
        final combined = '${dateTimePairs[i]['date']}|${dateTimePairs[i]['time']}';
        if (seen.contains(combined)) {
          dateErrors[i] = true;
          timeErrors[i] = true;
          isValid = false;
        } else {
          seen.add(combined);
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
      padding: EdgeInsets.only(bottom: 35.h),
      child: Row(
        children: [
          DateField(
            hasError: dateErrors[index],
            onChanged: (value) {
              setState(() {
                dateTimePairs[index]['date'] = value;
                dateErrors[index] = value.isEmpty;
              });
            },
          ),
          SizedBox(width: 4.w),
          TimeField(
            hasError: timeErrors[index],
            onChanged: (value) {
              setState(() {
                dateTimePairs[index]['time'] = value;
                timeErrors[index] = value.isEmpty;
              });
            },
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
            icon: Icon(Icons.add_circle_outline, color: Colors.black, size: 8.w),
            onPressed: addDateTimePair,
          ),
        ],
      ),
    );
  }
}
