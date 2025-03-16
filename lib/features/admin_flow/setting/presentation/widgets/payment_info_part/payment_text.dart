import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls/view/halls.dart';
import '../Text_filed.dart';

class PaymentText extends StatefulWidget {
  const PaymentText({super.key});

  @override
  State<PaymentText> createState() => PaymentTextState();
}

class PaymentTextState extends State<PaymentText> {
  // ✅ Controllers لكل حقل
  final TextEditingController _beneficiaryController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _swiftCodeController = TextEditingController();

  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  final RegExp _numberRegExp = RegExp(r"^[0-9]+$");
  final RegExp _ibanRegExp = RegExp(r"^[A-Z0-9]+$");
  final RegExp _swiftCodeRegExp = RegExp(r"^[A-Z0-9]{8,11}$");


  String? _beneficiaryError;
  String? _countryError;
  String? _bankNameError;
  String? _accountNumberError;
  String? _ibanError;
  String? _swiftCodeError;


  bool validateFields() {
    setState(() {
      _beneficiaryError = _validateName(_beneficiaryController.text.trim(), min: 3, max: 70);
      _countryError = _validateName(_countryController.text.trim(), min: 2, max: 40);
      _bankNameError = _validateName(_bankNameController.text.trim(), min: 3, max: 50);
      _accountNumberError = _validateNumber(_accountNumberController.text.trim(), min: 8, max: 16);
      _ibanError = _validateIBAN(_ibanController.text.trim(), min: 15, max: 34);
      _swiftCodeError = _validateSwift(_swiftCodeController.text.trim(), min: 8, max: 11);
    });

    return _beneficiaryError == null &&
        _countryError == null &&
        _bankNameError == null &&
        _accountNumberError == null &&
        _ibanError == null &&
        _swiftCodeError == null;
  }
  String? _validateName(String value, {int min = 1, int max = 70}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_nameRegExp.hasMatch(value)) return "⚠️ Only letters allowed!";
    if (value.length < min || value.length > max) return "⚠️ Length must be $min - $max characters!";
    return null;
  }

  String? _validateNumber(String value, {int min = 1, int max = 16}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_numberRegExp.hasMatch(value)) return "⚠️ Only numbers allowed!";
    if (value.length < min || value.length > max) return "⚠️ Length must be $min - $max digits!";
    return null;
  }


  String? _validateIBAN(String value, {int min = 15, int max = 34}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_ibanRegExp.hasMatch(value)) return "⚠️ IBAN must be uppercase letters and numbers!";
    if (value.length < min || value.length > max) return "⚠️ Length must be $min - $max characters!";
    return null;
  }


  String? _validateSwift(String value, {int min = 8, int max = 11}) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_swiftCodeRegExp.hasMatch(value)) return "⚠️ Swift Code must be uppercase letters & numbers!";
    if (value.length < min || value.length > max) return "⚠️ Length must be $min - $max characters!";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField("Beneficiary Name*", _beneficiaryController, _beneficiaryError)),

            Expanded(child: _buildTextField("Country*", _countryController, _countryError)),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Expanded(child: _buildTextField("Bank Name*", _bankNameController, _bankNameError)),
            Expanded(child: _buildTextField("Account Number", _accountNumberController, _accountNumberError)),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Expanded(child: _buildTextField("IBAN", _ibanController, _ibanError)),
            Expanded(child: _buildTextField("Swift Code", _swiftCodeController, _swiftCodeError)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String? error) {
    return TextFiled(
      label: label,
      controller: controller,
      errorText: error,
      hintText: "",
    );
  }

  @override
  void dispose() {
    _beneficiaryController.dispose();
    _countryController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    _swiftCodeController.dispose();
    super.dispose();
  }
}
