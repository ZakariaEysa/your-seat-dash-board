import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomDropdownWidget extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const RoomDropdownWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<RoomDropdownWidget> createState() => RoomDropdownWidgetState();
}

class RoomDropdownWidgetState extends State<RoomDropdownWidget> {
  final List<String> rooms = ['ROOM 1', 'ROOM 2', 'ROOM 3', 'ROOM 4'];

  String? selectedRoom;
  String? lastSavedRoom;
  bool roomError = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && rooms.contains(widget.initialValue)) {
      selectedRoom = widget.initialValue;
    } else {
      selectedRoom = null;
    }
  }

  bool validate() {
    setState(() {
      roomError = selectedRoom == null;
      if (!roomError) {
        lastSavedRoom = selectedRoom;
      }
    });
    return !roomError;
  }

  void resetToSaved() {
    setState(() {
      selectedRoom = lastSavedRoom;
      roomError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: Container(
        width: 35.w,
        height: 51.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: roomError ? Colors.red : Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: DropdownButton<String>(
          value: selectedRoom,
          hint: Text(
            'Room',
            style: TextStyle(color: Colors.black, fontSize: 4.sp),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          items: rooms.map((String room) {
            return DropdownMenuItem<String>(
              value: room,
              child: Text(room, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedRoom = value;
              roomError = false;
            });
            widget.onChanged(value);
          },
          isExpanded: true,
          underline: const SizedBox.shrink(),
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
