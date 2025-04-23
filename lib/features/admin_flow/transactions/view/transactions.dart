import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/presentation/cubit/payment_cubit.dart';
import '../widgets/sales_container.dart';
import '../widgets/payment_table.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  void initState() {
    super.initState();
    PaymentCubit.get(context).getAllTransactions();
  }

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

Map<String, dynamic> parseDate(String createdAt) {
  DateTime date = DateTime.parse(createdAt);

  String month = _getMonthName(date.month); // February مثلاً
  int day = date.day; // 19
  int year = date.year; // 2025

  return {
    'month': month,
    'day': day,
    'year': year,
  };
}

String _getMonthName(int monthNumber) {
  const months = [
    'January',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[monthNumber - 1];
}
