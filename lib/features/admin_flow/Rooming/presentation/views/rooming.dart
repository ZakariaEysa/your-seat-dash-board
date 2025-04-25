import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/button/button_builder.dart';
import '../../../rooming_sechduling/presentation/widgets/schedule_item.dart';
import '../widgets/date_time/date_screen.dart';
import '../widgets/rooming_validator.dart';

class Rooming extends StatefulWidget {
  final List<ScheduleItem> scheduleItems;

  const Rooming({super.key, required this.scheduleItems});

  @override
  State<Rooming> createState() => _RoomingState();
}

class _RoomingState extends State<Rooming> {
  final GlobalKey<DateTimeFieldsState> dateTimeKey = GlobalKey();

  void addSchedule() {
    final dateTimeFieldsState = dateTimeKey.currentState;
    if (dateTimeFieldsState == null) return;

    final items = dateTimeFieldsState.getAllSchedules();

    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all information correctly.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ Validate time correctness
    final validationMessage = RoomingValidator.validateScheduleItems(items);
    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ Check for conflict with existing schedules
    final conflictMessage = RoomingValidator.checkConflictWithExisting(
        widget.scheduleItems, items);
    if (conflictMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(conflictMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ Check for exact duplicates
    final existingKeys = widget.scheduleItems.map((item) =>
    '${item.room}|${item.movie}|${item.startDate}|${item.startTime}|${item.endDate}|${item.endTime}'
    ).toSet();

    final newItems = items.where((item) {
      final key = '${item.room}|${item.movie}|${item.startDate}|${item.startTime}|${item.endDate}|${item.endTime}';
      return !existingKeys.contains(key);
    }).toList();

    if (newItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This schedule already exists.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // ✅ Add to schedule
    setState(() {
      widget.scheduleItems.insertAll(0, newItems);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tables added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DateTimeFields(
                key: dateTimeKey,
              ),
              SizedBox(height: screenHeight * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Add',
                    onTap: addSchedule,
                    width: 40.w,
                    height: 50.h,
                    buttonColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 7.sp),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
