import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Text_filed.dart';

class CinemaText extends StatefulWidget {
  const CinemaText({super.key});

  @override
  State<CinemaText> createState() => CinemaTextState();
}

class CinemaTextState extends State<CinemaText> {
  // ✅ Controllers
  final TextEditingController _cinemaNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _managerController = TextEditingController();

  // ✅ Regex للتحقق
  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
  final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  final RegExp _phoneRegExp = RegExp(r"^[0-9]{11}$");

  // ✅ أخطاء الحقول
  String? _cinemaNameError;
  String? _emailError;
  String? _phoneError;
  String? _managerError;

  // ✅ التحقق من الحقول
  bool validateFields() {
    setState(() {
      _cinemaNameError = _validateName(_cinemaNameController.text.trim());
      _emailError = _validateEmail(_emailController.text.trim());
      _phoneError = _validatePhone(_phoneController.text.trim());
      _managerError = _validateName(_managerController.text.trim());
    });

    return _cinemaNameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _managerError == null;
  }

  // ✅ التحقق من الاسم
  String? _validateName(String value) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_nameRegExp.hasMatch(value)) return "⚠️ Only letters allowed!";
    return null;
  }

  // ✅ التحقق من الإيميل
  String? _validateEmail(String value) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_emailRegExp.hasMatch(value)) return "⚠️ Enter a valid email!";
    return null;
  }

  // ✅ التحقق من الرقم
  String? _validatePhone(String value) {
    if (value.isEmpty) return "⚠️ This field is required!";
    if (!_phoneRegExp.hasMatch(value)) return "⚠️ Must be 11 digits!";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFiled(
                label: "Cinema Name in English*",
                controller: _cinemaNameController,
                onChanged: (value) => setState(() => _cinemaNameError = null),
                onFieldSubmitted: (value) => setState(() => _cinemaNameError = _validateName(value)),
                errorText: _cinemaNameError,
                hintText: 'Musfiq  Mohammed',
              ),
            ),

            Expanded(
              child: TextFiled(
                label: "Email Address*",
                controller: _emailController,
                onChanged: (value) => setState(() => _emailError = null),
                onFieldSubmitted: (value) => setState(() => _emailError = _validateEmail(value)),
                errorText: _emailError,
                hintText: 'musfiqmohammed123@gmail.com',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Expanded(
              child: TextFiled(
                label: "Phone Number*",
                controller: _phoneController,
                onChanged: (value) => setState(() => _phoneError = null),
                onFieldSubmitted: (value) => setState(() => _phoneError = _validatePhone(value)),
                errorText: _phoneError,
                hintText: '01025687431',
              ),
            ),
            Expanded(
              child: TextFiled(
                label: "Cinema Manager Name*",
                controller: _managerController,
                onChanged: (value) => setState(() => _managerError = null),
                onFieldSubmitted: (value) => setState(() => _managerError = _validateName(value)),
                errorText: _managerError,
                hintText: 'Musfiq ',
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cinemaNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _managerController.dispose();
    super.dispose();
  }
}
