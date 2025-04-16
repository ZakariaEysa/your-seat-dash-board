import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/button/button_builder.dart';
import '../widgets/basic_hall.dart';

class Halls2 extends StatefulWidget {
  const Halls2({super.key});

  @override
  State<Halls2> createState() => _Halls2State();
}

class _Halls2State extends State<Halls2> {
  final List<GlobalKey<HallConfigPageState>> hallKeys = [
    GlobalKey<HallConfigPageState>()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Add Hall Button
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 270.w),
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hallKeys.add(GlobalKey<HallConfigPageState>());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF560B76),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.white, size: 7.sp),
                      SizedBox(width: 2.w),
                      Text(
                        'Add Hall',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 4.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Halls Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: hallKeys.length,
                itemBuilder: (context, index) {
                  return HallConfigPage(key: hallKeys[index]);
                },
              ),
            ),

            // Save / Cancel Buttons
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Save',
                    onTap: () {
                      bool allValid = true;
                      for (var key in hallKeys) {
                        if (key.currentState?.validate() != true) {
                          allValid = false;
                        }
                      }

                      if (allValid) {
                        print("✅ All halls valid. Proceed to save.");
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Please fix all errors before saving')),
                        // );
                        print("❌ Some halls are invalid.");
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
                    onTap: () {
                      // Cancel logic
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}