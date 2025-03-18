import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';


class MovieInfoScreen extends StatefulWidget {
  @override
  _MovieInfoScreenState createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  final TextEditingController _movieNameController = TextEditingController();
  final TextEditingController _movieGenreController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _censorshipController = TextEditingController();

  @override
  void dispose() {
    _movieNameController.dispose();
    _movieGenreController.dispose();
    _languageController.dispose();
    _censorshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      height: 295.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.only(top: 30.h, left: 10.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Movie Name"),
                SizedBox(height: 5.h),
                _buildTextField(),
                SizedBox(height: 15.h),
                _buildLabel("Language"),
                SizedBox(height: 10.h),
                _buildTextField(),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Movie Genre"),
                SizedBox(height: 10.h),
                _buildTextField(),
                SizedBox(height: 15.h),
                _buildLabel("Censorship"),
                SizedBox(height: 10.h),
                _buildTextField(),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/avatar_film.png",
                  width: 50.w,
                  height: 130.h,
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    SizedBox(width: 5.w),
                    ButtonBuilder(
                      text: 'Upload',
                      onTap: () {},
                      width: 30.w,
                      height: 51.h,
                      buttonColor: Color(0xFF560B76),
                      frameColor: Color(0xFF560B76),
                      borderShape: BorderRadius.circular(15.r),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 6.sp,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 4.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 5.sp,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      width: 140.w,
      height: 45.h,
      child: NewTextField(),
    );
  }
}
