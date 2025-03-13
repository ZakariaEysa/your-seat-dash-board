import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomMovie extends StatefulWidget {
  const RoomMovie({super.key});

  @override
  State<RoomMovie> createState() => _RoomMovieSelectionPageState();
}

class _RoomMovieSelectionPageState extends State<RoomMovie> {
  String? selectedRoom;
  String? selectedMovie;

  final List<String> rooms = ['ROOM 1', 'ROOM 2', 'ROOM 3', 'ROOM 4'];
  final List<String> movies = [
    'Avengers: Infinity War',
    'Guardians Of The Galaxy',
    'Shang chi: Legend of the Ten Rings'
  ];

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
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoom = newValue;
                  });
                },
              ),
              SizedBox(width:10.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                width: 60.w,
                height: 51.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButton<String>(
                  value: selectedMovie,
                  hint: Text(
                    'Movie name',
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: movies.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMovie = newValue;
                    });
                  },
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
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

  const DropdownWidget({
    required this.hintText,
    required this.selectedValue,
    required this.itemsList,
    required this.onChanged,
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
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text(
          hintText,
          style: TextStyle(color: Colors.black),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        items: itemsList.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}