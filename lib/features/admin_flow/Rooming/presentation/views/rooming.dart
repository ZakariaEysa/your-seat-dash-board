import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/date_time/date_screen.dart';
import '../widgets/movie_room/movie_select.dart';
import '../widgets/movie_room/room_Select.dart';

class Rooming extends StatefulWidget {
  const Rooming({super.key});

  @override
  State<Rooming> createState() => _RoomingState();
}

class _RoomingState extends State<Rooming> {
  final GlobalKey<RoomDropdownWidgetState> roomKey = GlobalKey();
  final GlobalKey<MovieDropdownWidgetState> movieKey = GlobalKey();
  final GlobalKey<DateTimeFieldsState> dateTimeKey = GlobalKey();

  bool validateSelection() {
    final roomValid = roomKey.currentState?.validate() ?? false;
    final movieValid = movieKey.currentState?.validate() ?? false;
    return roomValid && movieValid;
  }

  void resetAll() {
    roomKey.currentState?.resetToSaved();
    movieKey.currentState?.resetToSaved();
    dateTimeKey.currentState?.resetFields();
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
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:EdgeInsets.only(top: 65.h),
                      child: Row(
                        children: [
                          RoomDropdownWidget(key: roomKey),
                          SizedBox(width: 5.w),
                          MovieDropdownWidget(key: movieKey),
                        ],
                      ),
                    ),

                    SizedBox(width: 5.w),
                    Expanded(child: DateTimeFields(key: dateTimeKey)),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Add',
                    onTap: () {
                      final isRoomMovieValid = validateSelection();
                      final isDateTimeValid = dateTimeKey.currentState?.validateDateTime() ?? false;

                      if (isRoomMovieValid && isDateTimeValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Booking added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete Room,Movie,Date,and Time!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    width: 40.w,
                    height: 50.h,
                    buttonColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ButtonBuilder(
                    text: 'Cancel',
                    onTap: resetAll,
                    width: 40.w,
                    height: 50.h,
                    buttonColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
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
