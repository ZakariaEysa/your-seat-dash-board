import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_number.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_price.dart';

import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class HallConfigPage extends StatefulWidget {
  const HallConfigPage({super.key});

  @override
  HallConfigPageState createState() => HallConfigPageState();
}

class HallConfigPageState extends State<HallConfigPage> {
  final TextEditingController _hallNameController = TextEditingController();
  bool _hasError = false;
  String? _errorMessage;

  bool validate() {
    final text = _hallNameController.text.trim();
    setState(() {
      _hasError = false;
      _errorMessage = null;

      if (text.isEmpty) {
        _hasError = true;
        _errorMessage = 'Hall name is required';
      } else if (text.length > 20) {
        _hasError = true;
        _errorMessage = 'At most 20 characters';
      }
    });
    return !_hasError;
  }

  @override
  void dispose() {
    _hallNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.sp),
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(8.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hall Name
              Row(
                children: [
                  Text(
                    "Hall Name : ",
                    style: TextStyle(
                      fontSize: 6.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: NewTextField(
                      // controller: _hallNameController,
                      // borderColor: _hasError ? Colors.red : Colors.black,
                      // errorText: _hasError ? _errorMessage : null,
                      // keyboardType: TextInputType.text,
                      // onChanged: (_) {
                      //   if (_hasError) {
                      //     setState(() {
                      //       _hasError = false;
                      //       _errorMessage = null;
                      //     });
                      //   }
                      // },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const SeatNumberSection(),
              SizedBox(height: 17.h),
              const SeatPriceSection(),
            ],
          ),
        ),
      ),
    );
  }
}
