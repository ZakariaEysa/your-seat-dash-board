import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/cubit/settings_cubit.dart';
import '../../../../../../utils/validation_utils.dart';
import '../Text_filed.dart';

class CinemaText extends StatefulWidget {
  const CinemaText({super.key});

  @override
  State<CinemaText> createState() => CinemaTextState();
}

class CinemaTextState extends State<CinemaText> {
  String? _cinemaNameError;
  String? _emailError;
  String? _phoneError;
  String? _managerError;

  // ✅ التحقق من الحقول
  bool validateFields() {
    setState(() {
      _cinemaNameError = validateName(
          SettingsCubit.get(context).cinemaNameController.text.trim());
      _emailError =
          validateEmail(SettingsCubit.get(context).emailController.text.trim());
      _phoneError =
          validatePhone(SettingsCubit.get(context).phoneController.text.trim());
      _managerError = validateName(
          SettingsCubit.get(context).managerController.text.trim());
    });

    return _cinemaNameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _managerError == null;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = SettingsCubit.get(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFiled(
                label: "Cinema Name in English*",
                controller: cubit.cinemaNameController,
                onChanged: (value) => setState(() => _cinemaNameError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _cinemaNameError = validateName(value)),
                errorText: _cinemaNameError,
                hintText: 'Musfiq  Mohammed',
              ),
            ),
            Expanded(
              child: TextFiled(
                label: "Email Address*",
                controller: cubit.emailController,
                onChanged: (value) => setState(() => _emailError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _emailError = validateEmail(value)),
                errorText: _emailError,
                hintText: 'musfiqmohammed123@gmail.com',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
              child: TextFiled(
                label: "Phone Number*",
                controller: cubit.phoneController,
                onChanged: (value) => setState(() => _phoneError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _phoneError = validatePhone(value)),
                errorText: _phoneError,
                hintText: '01025687431',
              ),
            ),
            Expanded(
              child: TextFiled(
                label: "Cinema Manager Name*",
                controller: cubit.managerController,
                onChanged: (value) => setState(() => _managerError = null),
                onFieldSubmitted: (value) =>
                    setState(() => _managerError = validateName(value)),
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
    SettingsCubit.get(context).cinemaNameController.dispose();
    SettingsCubit.get(context).emailController.dispose();
    SettingsCubit.get(context).phoneController.dispose();
    SettingsCubit.get(context).managerController.dispose();
    super.dispose();
  }
}
