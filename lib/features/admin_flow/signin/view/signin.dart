import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/button/button_builder.dart';
import '../../../../widgets/list/list.dart';
import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailError = false;
  bool _passwordError = false;
  String _emailErrorMessage = '';
  String _passwordErrorMessage = '';

  // Email validation function (Gmail only)
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@admin\.com$');
    return emailRegex.hasMatch(email);
  }

  // Password validation function
  bool _validatePassword(String password) {
    return password.length >= 8;
  }

  // Validate all fields
  void _validateFields() {
    setState(() {
      _emailError = false;
      _passwordError = false;
      _emailErrorMessage = '';
      _passwordErrorMessage = '';

      // Email validation
      if (_emailController.text.isEmpty) {
        _emailError = true;
        _emailErrorMessage = 'Email is required';
      } else if (!_validateEmail(_emailController.text)) {
        _emailError = true;
        _emailErrorMessage = 'Email must be a valid';
      }

      // Password validation
      if (_passwordController.text.isEmpty) {
        _passwordError = true;
        _passwordErrorMessage = 'Password is required';
      } else if (!_validatePassword(_passwordController.text)) {
        _passwordError = true;
        _passwordErrorMessage = 'Password must be at least 8 characters';
      }

      // If all validations pass, navigate to NavigationList
      if (!_emailError && !_passwordError) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavigationList()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF560b76),
              child: Center(
                child: Image.asset('assets/images/sign_in.png', height: 300),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:  EdgeInsets.only(left:50.w,right: 50.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50.w, top: 50.h),
                        child: Text(
                          "sign in",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF6b307d),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 22.w, top: 30.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email : ",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: const Color(0xFF6b307d),
                              ),
                            ),
                            SizedBox(height: 5.h),

                              NewTextField(
                                textAlign: TextAlign.right, // إضافة هذا السطر

                                controller: _emailController,
                                borderColor: _emailError
                                    ? Colors.red
                                    : Color(0xFFd7b6e1),
                                hintText: "example@gmail.com",
                                errorText:
                                    _emailError ? _emailErrorMessage : null,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 10.w),
                              ),

                            SizedBox(height: 35.h),
                            Text(
                              "Password :",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: const Color(0xFF6b307d),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            NewTextField(
                              controller: _passwordController,
                              borderColor: _passwordError
                                  ? Colors.red
                                  : Color(0xFFd7b6e1),
                              obscureText: true,
                              hintText: "1234Aa?*",
                              errorText: _passwordError
                                  ? _passwordErrorMessage
                                  : null,
                              contentPadding: EdgeInsets.symmetric(
                                 // vertical: 12.h,
                                  horizontal: 10.w), // إضافة هذا السطر
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Center(
                        child: ButtonBuilder(
                          text: 'Sign In',
                          onTap: _validateFields,
                          width: 40.w,
                          height: 50.h,
                          buttonColor: Color(0xFF560B76),
                          borderShape: BorderRadius.circular(10.r),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 7.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
