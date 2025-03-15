import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/button/button_builder.dart';
import '../widgets/basic_hall.dart';

class Halls extends StatefulWidget {
  @override
  _HallsState createState() => _HallsState();
}

class _HallsState extends State<Halls> {
  List<Widget> halls = [BasicHall.BasicHall()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 270.w),
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      halls.add(BasicHall.BasicHall());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF560B76),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.white, size: 7.sp),
                      SizedBox(width: 2.w),
                      Text('Add Hall', style: TextStyle(color: Colors.white, fontSize:4.sp,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: halls.length,
                itemBuilder: (context, index) {
                  return halls[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Save',
                    onTap: () {},
                    width: 40.w,
                    height: 50.h,
                    buttonColor: Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ButtonBuilder(
                    text: 'cancel',
                    onTap: () {},
                    width: 40.w,
                    height: 50.h,
                    buttonColor: Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}