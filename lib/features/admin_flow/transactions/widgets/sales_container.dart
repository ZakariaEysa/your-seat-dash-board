import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/transactions/widgets/sales_card.dart';

class SalesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700.w,
        height: 310.h,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sales Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF737791),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SalesCard(
                        title: 'Complete Transactions',
                        value: '15',
                        color: Color(0xFFFFE2E5),
                        imagePath: 'assets/images/sale1.png',
                      ),
                      SalesCard(
                        title: 'Refund Transactions',
                        value: '23',
                        color: Color(0xFFFFF4DE),
                        imagePath: 'assets/images/sale2.png',
                      ),
                      SalesCard(
                        title: 'Total Amount',
                        value: '50',
                        color: Color(0xFFDCFCE7),
                        imagePath: 'assets/images/sale3.png',
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
