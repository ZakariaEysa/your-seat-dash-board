import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/Text_filed.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Container(
                      width: 959.95.w,
                      height: 668.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h, left: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank info",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:7.sp),
                            ),
                            Text(
                              "Update your Bank info",
                              style: TextStyle(
                                  color: Color(0xFF625C5C), fontSize: 3.sp),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFiled(
                                  label: "Beneficiary Name*",
                                )),
                                Expanded(
                                    child: TextFiled(
                                  label: "Country*",
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFiled(
                                  label: "Bank Name",
                                )),
                                Expanded(
                                    child: TextFiled(
                                  label: "Account Number",
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFiled(
                                  label: "IBAN",
                                )),
                                Expanded(
                                    child: TextFiled(
                                  label: "Swift Code",
                                )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 60.w, top: 60.h),
                                child: Row(
                                  children: [
                                    ButtonBuilder(
                                      text:'Save',
                                      onTap: () {},
                                      width: 45.w,
                                      height: 60.h,
                                      buttonColor: Color(0xFF560B76),
                                      frameColor: Color(0xFF560B76),
                                      borderShape: BorderRadius.circular(15.r),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:8.sp,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    ButtonBuilder(
                                      text: 'Cancel',
                                      onTap: () {},
                                      width: 45.w,
                                      height: 60.h,
                                      buttonColor: Color(0xFFF3F3F3),
                                      frameColor: Colors.black,
                                      borderShape: BorderRadius.circular(15.r),
                                      style: TextStyle(
                                        color:  Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:8.sp,
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )))),
        ));
  }
}
