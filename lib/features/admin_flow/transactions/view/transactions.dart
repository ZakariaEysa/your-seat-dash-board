import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/sales_container.dart';
import '../widgets/payment_table.dart';

class Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SalesContainer(),
                SizedBox(height: 20.h),
                SizedBox(width: 860.w, child: PaymentTable()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
