import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/widgets/list/list.dart';

import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  Future<void> _signIn(BuildContext context, String email, String password) async {
    try {
      final adminUsersRef = FirebaseFirestore.instance.collection('admin_users');
      final querySnapshot = await adminUsersRef.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        print('Email not found');
        return;
      }

      final docData = querySnapshot.docs.first.data();

      if (docData['password'] == password) {
        print('Login successful');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavigationList()),
        );
      } else {
        print('Incorrect password');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return   Padding(
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
          SizedBox(
            width: 340.w,
            height: 50.h,
            child:  NewTextField(
              controller: emailController ,
              borderColor: const Color(0xFFd7b6e1),
              hintText: "Example26@admin.com",
            ),
          ),
          SizedBox(height: 25.h),
          Text(
            "Password :",
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF6b307d),
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 340.w,
            height: 50.h,
            child:  NewTextField(
              controller: passwordController,
              borderColor: Color(0xFFd7b6e1),
              obscureText: true,
              hintText: "1234Aa?*",
            ),
          )
        ],
      ),
    );
  }
}
