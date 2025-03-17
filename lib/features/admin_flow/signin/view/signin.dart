// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../widgets/button/button_builder.dart';
// import '../widgets/log_in.dart';
// class SignIn extends StatelessWidget {
//   const SignIn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             child: Container(
//               color: const Color(0xFF560b76),
//               child: Center(
//                 child: Image.asset('assets/images/sign_in.png', height: 300),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(50),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 50.w, top: 50.h),
//                       child: Text(
//                         "sign in",
//                         style: TextStyle(
//                           //fontFamily: "Potta One",
//                           fontSize: 14.sp,
//                           color: const Color(0xFF6b307d),
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//
//                     LogIn(),
//                     SizedBox(height: 30.h,),
//
//                     ButtonBuilder(
//                       text: 'Sign In',
//                       onTap: () {},
//                       width: 40.w,
//                       height: 50.h,
//                       buttonColor: Color(0xFF560B76),
//                       borderShape: BorderRadius.circular(10.r),
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 7.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../utils/app_logs.dart';
import '../../../../widgets/button/button_builder.dart';
import '../../../../widgets/list/list.dart';
import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../widgets/log_in.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  Future<void> _signIn(
      BuildContext context, String email, String password) async {
    try {
      final adminUsersRef =
          FirebaseFirestore.instance.collection('admin_users');
      final querySnapshot =
          await adminUsersRef.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        print('Email not found');
        return;
      }

      final docData = querySnapshot.docs.first.data();

      if (docData['password'] == password) {
        print('Login successful');

        LocalStorageService.saveUserData(email);

        print(LocalStorageService.getUserData());
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
    AppLogs.scussessLog(LocalStorageService.getUserData().toString());

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFF560b76),
              child: Center(
                child: Image.asset('assets/images/sign_in.png', height: 300),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50.w, top: 50.h),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF6b307d),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //const LogIn(),
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
                          SizedBox(
                            width: 340.w,
                            height: 50.h,
                            child: NewTextField(
                              controller: emailController,
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
                            child: NewTextField(
                              controller: passwordController,
                              borderColor: Color(0xFFd7b6e1),
                              obscureText: true,
                              hintText: "1234Aa?*",
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ButtonBuilder(
                      text: 'Sign In',
                      onTap: () {
                        _signIn(context, emailController.text,
                            passwordController.text);
                      },
                      width: 40.w,
                      height: 50.h,
                      buttonColor: const Color(0xFF560B76),
                      borderShape: BorderRadius.circular(10.r),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 7.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
