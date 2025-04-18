import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomMovie extends StatefulWidget {
  const RoomMovie({super.key});

  @override
  State<RoomMovie> createState() => RoomMovieSelectionPageState();
}

class RoomMovieSelectionPageState extends State<RoomMovie> {
  String? selectedRoom;
  String? selectedMovie;

  String? savedRoom = 'ROOM 2';
  String? savedMovie = 'Avengers: Infinity War';

  final List<String> rooms = ['ROOM 1', 'ROOM 2', 'ROOM 3', 'ROOM 4'];
  final List<String> movies = [
    'Avengers: Infinity War',
    'Guardians Of The Galaxy',
    'Shang chi: Legend of the Ten Rings'
  ];

  bool roomError = false;
  bool movieError = false;


  /// ✅ Validate input fields
  bool validateSelection() {
    setState(() {
      roomError = selectedRoom == null;
      movieError = selectedMovie == null;
    });
    return !roomError && !movieError;
  }

  /// ✅ Reset للقيم المحفوظة
  void resetToSaved() {
    setState(() {
      selectedRoom = savedRoom;
      selectedMovie = savedMovie;
      roomError = false;
      movieError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownWidget(
                hintText: 'ROOM',
                selectedValue: selectedRoom,
                itemsList: rooms,
                hasError: roomError,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoom = newValue;
                    roomError = false;
                  });
                },
              ),
              SizedBox(width: 10.w),
              DropdownWidget(
                hintText: 'Movie name',
                selectedValue: selectedMovie,
                itemsList: movies,
                hasError: movieError,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMovie = newValue;
                    movieError = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final String hintText;
  final String? selectedValue;
  final List<String> itemsList;
  final ValueChanged<String?> onChanged;
  final bool hasError;

  const DropdownWidget({
    required this.hintText,
    required this.selectedValue,
    required this.itemsList,
    required this.onChanged,
    this.hasError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: 60.w,
      height: 51.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: hasError ? Colors.red : Colors.black),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text(
          hintText,
          style: const TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        items: itemsList.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
