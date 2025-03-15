import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls/widgets/seat_detailes.dart';
import 'package:yourseatgraduationproject/widgets/text_field/text_field/new_text_field_builder.dart';

class HallDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:  EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Hall Name :', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(width:10),
                SizedBox(width:250, height:45, child: NewTextField()),
              ],
            ),
             SizedBox(height: 5),
            Container(
              
              color: const Color(0xFFBFBFBF),
              padding:  EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SeatDetails(title: 'Number for seat', textColor: Colors.black)),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_circle_outline, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
             SizedBox(height: 10),
      
            Container(
              color: const Color(0xFFBFBFBF),
              padding:  EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SeatDetails(title: 'Price for seat', textColor: Colors.black)),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_circle_outline, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
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
