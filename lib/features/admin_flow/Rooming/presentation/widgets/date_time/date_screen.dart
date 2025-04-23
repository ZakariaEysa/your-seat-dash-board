import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'date_time_group_row.dart';

class DateTimeFields extends StatefulWidget {
  const DateTimeFields({super.key});

  @override
  State<DateTimeFields> createState() => DateTimeFieldsState();
}

class DateTimeFieldsState extends State<DateTimeFields> {
  List<Map<String, String>> dateTimePairs = [
    {'date': '', 'time': ''},
    {'date': '', 'time': ''},
  ];

  List<Map<String, String>> lastSavedDateTimePairs = [];
  List<bool> dateErrors = [false, false];
  List<bool> timeErrors = [false, false];

  void addDateTimePair() {
    setState(() {
      for (int i = 0; i < 2; i++) {
        dateTimePairs.add({'date': '', 'time': ''});
        dateErrors.add(false);
        timeErrors.add(false);
      }
    });
  }

  void removeDateTimeGroup(int index) {
    if (dateTimePairs.length <= 2) return;
    setState(() {
      dateTimePairs.removeAt(index);
      dateErrors.removeAt(index);
      timeErrors.removeAt(index);
      if (index < dateTimePairs.length) {
        dateTimePairs.removeAt(index);
        dateErrors.removeAt(index);
        timeErrors.removeAt(index);
      }
    });
  }

  bool validateDateTime() {
    bool isValid = true;
    Set<String> seenPairs = {};

    setState(() {
      for (int i = 0; i < dateTimePairs.length; i++) {
        String date = dateTimePairs[i]['date']!;
        String time = dateTimePairs[i]['time']!;
        bool dateEmpty = date.isEmpty;
        bool timeEmpty = time.isEmpty;

        dateErrors[i] = dateEmpty;
        timeErrors[i] = timeEmpty;

        if (dateEmpty || timeEmpty) {
          isValid = false;
        }

        String key = '$date|$time';
        if (!dateEmpty && !timeEmpty) {
          if (seenPairs.contains(key)) {
            isValid = false;
            dateErrors[i] = true;
            timeErrors[i] = true;
          } else {
            seenPairs.add(key);
          }
        }
      }

      if (isValid) {
        lastSavedDateTimePairs = List<Map<String, String>>.from(dateTimePairs);
      }
    });

    return isValid;
  }

  void resetFields() {
    setState(() {
      if (lastSavedDateTimePairs.isNotEmpty) {
        dateTimePairs = List<Map<String, String>>.from(lastSavedDateTimePairs);
        dateErrors = List.generate(dateTimePairs.length, (_) => false);
        timeErrors = List.generate(dateTimePairs.length, (_) => false);
      } else {
        dateTimePairs = [
          {'date': '', 'time': ''},
          {'date': '', 'time': ''},
        ];
        dateErrors = [false, false];
        timeErrors = [false, false];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 65.h, left: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < dateTimePairs.length; i += 2)
            DateTimeGroupRow(
              startIndex: i,
              dateTimePairs: dateTimePairs,
              dateErrors: dateErrors,
              timeErrors: timeErrors,
              onRemove: removeDateTimeGroup,
              onUpdate: () => setState(() {}),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.black, size: 5.sp),
              onPressed: addDateTimePair,
            ),
          ),
        ],
      ),
    );
  }
}
