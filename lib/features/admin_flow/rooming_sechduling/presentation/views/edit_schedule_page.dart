import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Edit_Schedule/end_fields.dart';
import '../widgets/Edit_Schedule/room_movie_fields.dart';
import '../widgets/Edit_Schedule/save_button.dart';
import '../widgets/Edit_Schedule/schedule_validator.dart';
import '../widgets/Edit_Schedule/start_fields.dart';
import '../widgets/schedule_item.dart';

class EditSchedulePage extends StatefulWidget {
  final ScheduleItem item;
  final Function(ScheduleItem updatedItem) onSave;

  const EditSchedulePage({super.key, required this.item, required this.onSave});

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  String? selectedRoom;
  String? selectedMovie;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;

  @override
  void initState() {
    super.initState();
    selectedRoom = widget.item.room;
    selectedMovie = widget.item.movie;
    startDate = widget.item.startDate;
    startTime = widget.item.startTime;
    endDate = widget.item.endDate;
    endTime = widget.item.endTime;
  }

  void saveChanges() {
    final validationMessage = ScheduleValidator.validateFields(
      room: selectedRoom,
      movie: selectedMovie,
      startDate: startDate,
      startTime: startTime,
      endDate: endDate,
      endTime: endTime,
      originalItem: widget.item,
    );

    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationMessage)),
      );
      return;
    }

    final updatedItem = ScheduleItem(
      room: selectedRoom!,
      movie: selectedMovie!,
      startDate: startDate!,
      startTime: startTime!,
      endDate: endDate!,
      endTime: endTime!,
    );

    widget.onSave(updatedItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Schedule updated successfully ✅")),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context);
    });
  }

  DateTime? _combineDateTime(String? date, String? time) {
    return ScheduleValidator.combineDateTime(date, time);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(4.0.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoomMovieFields(
                    selectedRoom: selectedRoom,
                    selectedMovie: selectedMovie,
                    onRoomChanged: (val) => setState(() => selectedRoom = val),
                    onMovieChanged: (val) => setState(() => selectedMovie = val),
                  ),
                  SizedBox(width: 3.w),
                  StartFields(
                    startDate: startDate,
                    startTime: startTime,
                    endDate: endDate,
                    parseDate: _parseDate,
                    onDateChanged: (val) => setState(() => startDate = val),
                    onTimeChanged: (val) {
                      final selectedDateTime = _combineDateTime(startDate, val);
                      if (selectedDateTime != null && selectedDateTime.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Start time can't be in the past ❌")),
                        );
                        return;
                      }
                      setState(() => startTime = val);
                    },
                  ),
                  SizedBox(width: 3.w),
                  EndFields(
                    endDate: endDate,
                    endTime: endTime,
                    startDate: startDate,
                    parseDate: _parseDate,
                    onDateChanged: (val) => setState(() => endDate = val),
                    onTimeChanged: (val) {
                      final selectedDateTime = _combineDateTime(endDate, val);
                      if (selectedDateTime != null && selectedDateTime.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("End time can't be in the past ❌")),
                        );
                        return;
                      }
                      setState(() => endTime = val);
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SaveButton(onPressed: saveChanges),
            ],
          ),
        ),
      ),
    );
  }
}
