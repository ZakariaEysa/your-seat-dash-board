import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    if (state is TransactionSuccess) {
                      return Column(
                        children: [
                          SalesContainer(),
                          SizedBox(height: 20.h),
                          SizedBox(
                              width: 860.w,
                              child: PaymentTable(
                                  transactions: state.transactions)),
                        ],
                      );
                    } else if (state is PaymentError) {
                      return Center(child: Text(state.error));
                    } else
                      return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
