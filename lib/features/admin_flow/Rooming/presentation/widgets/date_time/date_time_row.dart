import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/Rooming/presentation/widgets/date_time/time_field.dart';
import 'date_field.dart';

class DateTimeRow extends StatelessWidget {
  final int index;
  final List<Map<String, String>> dateTimePairs;
  final List<bool> dateErrors;
  final List<bool> timeErrors;
  final VoidCallback onUpdate;
  final String datePlaceholder;
  final String timePlaceholder;

  const DateTimeRow({
    super.key,
    required this.index,
    required this.dateTimePairs,
    required this.dateErrors,
    required this.timeErrors,
    required this.onUpdate,
    required this.datePlaceholder,
    required this.timePlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    final date = dateTimePairs[index]['date']!;
    final time = dateTimePairs[index]['time']!;
    final key = '$date|$time';

    final isDuplicate = dateTimePairs.asMap().entries.any((entry) =>
    entry.key != index &&
        '${entry.value['date']}|${entry.value['time']}' == key);

    final selectedDate = _parseDate(date); // 🟡 تحويل النص لتاريخ

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 70.h,
            child: DateField(
              key: ValueKey('date-$index-$date'),
              placeholder: datePlaceholder,
              initialValue: date,
              errorText: dateErrors[index]
                  ? (date.isEmpty
                  ? 'Please enter the date'
                  : (isDuplicate ? 'This date has already been added.' : null))
                  : null,
              onChanged: (value) {
                dateTimePairs[index]['date'] = value;
                onUpdate();
              },
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: SizedBox(
            height: 70.h,
            child: TimeField(
              key: ValueKey('time-$index-$time'),
              placeholder: timePlaceholder,
              initialValue: time,
              selectedDate: selectedDate ?? DateTime.now(), // 🟢 هنا التعديل المهم
              errorText: timeErrors[index]
                  ? (time.isEmpty
                  ? 'Please enter the timing'
                  : (isDuplicate ? 'This timing is already added.' : null))
                  : null,
              onChanged: (value) {
                dateTimePairs[index]['time'] = value;
                onUpdate();
              },
            ),
          ),
        ),
      ],
    );
  }

  DateTime? _parseDate(String value) {
    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }
}
