import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'date_time_row.dart';

class DateTimeGroupRow extends StatelessWidget {
  final int startIndex;
  final List<Map<String, String>> dateTimePairs;
  final List<bool> dateErrors;
  final List<bool> timeErrors;
  final void Function(int index) onRemove;
  final VoidCallback onUpdate;

  const DateTimeGroupRow({
    super.key,
    required this.startIndex,
    required this.dateTimePairs,
    required this.dateErrors,
    required this.timeErrors,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final int endIndex = startIndex + 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: DateTimeRow(
              index: startIndex,
              dateTimePairs: dateTimePairs,
              dateErrors: dateErrors,
              timeErrors: timeErrors,
              onUpdate: onUpdate, datePlaceholder: 'Start Date', timePlaceholder: 'Start Time',
            ),
          ),
          SizedBox(width: 8.w),
          if (endIndex < dateTimePairs.length)
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  DateTimeRow(
                    index: endIndex,
                    dateTimePairs: dateTimePairs,
                    dateErrors: dateErrors,
                    timeErrors: timeErrors,
                    onUpdate: onUpdate, datePlaceholder: 'End Date', timePlaceholder: 'End Time',
                  ),
                  if (dateTimePairs.length > 2 && startIndex >= 2)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 90.h),
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 5.sp),
                          onPressed: () => onRemove(startIndex),
                        ),
                      ),
                    ),
                ],
              ),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }
}
