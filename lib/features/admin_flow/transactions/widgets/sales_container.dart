import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourseatgraduationproject/features/admin_flow/transactions/widgets/sales.dart';

class SalesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 950,height: 300,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Sales(
                        title: 'Complete Transactions',
                        value: '15',
                        color: Color(0xFFFFE2E5),
                        imagePath: 'assets/images/sale1.png',
                      ),
                      Sales(
                        title: 'Refund Transactions',
                        value: '23',
                        color: Color(0xFFFFF4DE),
                        imagePath: 'assets/images/sale2.png',
                      ),
                      Sales(
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
