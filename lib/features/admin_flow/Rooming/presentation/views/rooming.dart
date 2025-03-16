import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/date.dart';
import '../widgets/room_Select.dart';

class Rooming extends StatelessWidget {
  const Rooming({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    final roomMovieKey = GlobalKey<RoomMovieSelectionPageState>();
    final dateTimeKey = GlobalKey<DateTimeFieldsState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  Flexible(child: RoomMovie(key: roomMovieKey)),
                  Flexible(child: DateTimeFields(key: dateTimeKey)),
                ],
              ),

              SizedBox(height: screenHeight * 0.25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Add',
                    onTap: () {
                      final isRoomMovieValid =
                          roomMovieKey.currentState?.validateSelection() ?? false;
                      final isDateTimeValid =
                          dateTimeKey.currentState?.validateDateTime() ?? false;

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
                            content:
                            Text('Please complete Room, Movie, Date, and Time!'),
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
                    onTap: () => Navigator.pop(context),
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
