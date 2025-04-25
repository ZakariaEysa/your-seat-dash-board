import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Rooming/presentation/widgets/date_time/date_field.dart';
import '../../../../Rooming/presentation/widgets/date_time/time_field.dart';


class StartFields extends StatelessWidget {
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final DateTime? Function(String) parseDate;
  final ValueChanged<String> onDateChanged;
  final ValueChanged<String> onTimeChanged;

  const StartFields({
    super.key,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.parseDate,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DateField(
          label: 'Start Date',
          initialValue: startDate,
          onChanged: onDateChanged,
          errorText: '',
          placeholder: '',
          compareWithDate: endDate != null ? parseDate(endDate!) : null,
          isStartDate: true,
        ),
        SizedBox(width:3.w,),
        TimeField(
          label: 'Start Time',
          initialValue: startTime,
          onChanged: onTimeChanged,
          errorText: '',
          placeholder: '',
        ),
      ],
    );
  }
}
