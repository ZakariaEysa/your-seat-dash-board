import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Rooming/presentation/widgets/movie_room/movie_select.dart';
import '../../../../Rooming/presentation/widgets/movie_room/room_Select.dart';

class RoomMovieFields extends StatelessWidget {
  final String? selectedRoom;
  final String? selectedMovie;
  final ValueChanged<String?> onRoomChanged;
  final ValueChanged<String?> onMovieChanged;

  const RoomMovieFields({
    super.key,
    required this.selectedRoom,
    required this.selectedMovie,
    required this.onRoomChanged,
    required this.onMovieChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoomDropdownWidget(
          initialValue: selectedRoom,
          onChanged: onRoomChanged,
        ),
        SizedBox(width: 3.w,),
        MovieDropdownWidget(
          initialValue: selectedMovie,
          onChanged: onMovieChanged,
        ),
      ],
    );
  }
}
