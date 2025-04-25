import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_number.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls2/widgets/seat_price.dart';
import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../widgets/validators/Validators.dart';

class HallConfigPage extends StatefulWidget {
  const HallConfigPage({Key? key}) : super(key: key);

  @override
  HallConfigPageState createState() => HallConfigPageState();
}

class HallConfigPageState extends State<HallConfigPage> {
  final TextEditingController _hallNameController = TextEditingController();
  final TextEditingController _vipSeatCountController = TextEditingController();
  final TextEditingController _premiumSeatCountController = TextEditingController();
  final TextEditingController _standardSeatCountController = TextEditingController();
  final TextEditingController _vipSeatPriceController = TextEditingController();
  final TextEditingController _premiumSeatPriceController = TextEditingController();
  final TextEditingController _standardSeatPriceController = TextEditingController();

  String? _hallNameError;
  String? _vipSeatCountError;
  String? _premiumSeatCountError;
  String? _standardSeatCountError;
  String? _vipSeatPriceError;
  String? _premiumSeatPriceError;
  String? _standardSeatPriceError;

  bool validate() {
    setState(() {
      _hallNameError = Validators.validateAnyText(
        _hallNameController.text,
        'Hall Name',
      );

      _vipSeatCountError = Validators.validateRequired(
        _vipSeatCountController.text,
        'Field',
        numbersOnly: true,
      );

      _premiumSeatCountError = Validators.validateRequired(
        _premiumSeatCountController.text,
        'Field',
        numbersOnly: true,
      );

      _standardSeatCountError = Validators.validateRequired(
        _standardSeatCountController.text,
        'Field',
        numbersOnly: true,
      );

      _vipSeatPriceError = Validators.validateRequired(
        _vipSeatPriceController.text,
        'Field',
        numbersOnly: true,
      );

      _premiumSeatPriceError = Validators.validateRequired(
        _premiumSeatPriceController.text,
        'Field',
        numbersOnly: true,
      );

      _standardSeatPriceError = Validators.validateRequired(
        _standardSeatPriceController.text,
        'Field',
        numbersOnly: true,
      );
    });

    return _hallNameError == null &&
        _vipSeatCountError == null &&
        _premiumSeatCountError == null &&
        _standardSeatCountError == null &&
        _vipSeatPriceError == null &&
        _premiumSeatPriceError == null &&
        _standardSeatPriceError == null;
  }

  @override
  void dispose() {
    _hallNameController.dispose();
    _vipSeatCountController.dispose();
    _premiumSeatCountController.dispose();
    _standardSeatCountController.dispose();
    _vipSeatPriceController.dispose();
    _premiumSeatPriceController.dispose();
    _standardSeatPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.sp),
      child: Container(
        width: 210.w,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(4.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hall Name
            Row(
              children: [
                Text(
                  "Hall Name : ",
                  style: TextStyle(
                    fontSize: 5.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: NewTextField(

                    controller: _hallNameController,
                    errorText: _hallNameError,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            SeatNumberSection(
              vipController: _vipSeatCountController,
              premiumController: _premiumSeatCountController,
              standardController: _standardSeatCountController,
              vipError: _vipSeatCountError,
              premiumError: _premiumSeatCountError,
              standardError: _standardSeatCountError,
            ),
            SizedBox(height: 8.h),
            SeatPriceSection(
              vipController: _vipSeatPriceController,
              premiumController: _premiumSeatPriceController,
              standardController: _standardSeatPriceController,
              vipError: _vipSeatPriceError,
              premiumError: _premiumSeatPriceError,
              standardError: _standardSeatPriceError,
            ),
          ],
        ),
      ),
    );
  }
}