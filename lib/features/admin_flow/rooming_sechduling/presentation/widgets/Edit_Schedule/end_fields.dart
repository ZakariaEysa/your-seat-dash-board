import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Rooming/presentation/widgets/date_time/date_field.dart';
import '../../../../Rooming/presentation/widgets/date_time/time_field.dart';

class EndFields extends StatelessWidget {
  final String? endDate;
  final String? endTime;
  final String? startDate;
  final DateTime? Function(String) parseDate;
  final ValueChanged<String> onDateChanged;
  final ValueChanged<String> onTimeChanged;

  const EndFields({
    super.key,
    required this.endDate,
    required this.endTime,
    required this.startDate,
    required this.parseDate,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DateField(
          label: 'End Date',
          initialValue: endDate,
          onChanged: onDateChanged,
          errorText: '',
          placeholder: '',
          compareWithDate: startDate != null ? parseDate(startDate!) : null,
          isStartDate: false,
        ),
        SizedBox(width:3.w,),
        TimeField(
          label: 'End Time',
          initialValue: endTime,
          onChanged: onTimeChanged,
          errorText: '',
          placeholder: '',
        ),
      ],
    );
  }
}
