import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/validators/Validators.dart';

class PersonNameField extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onAdd;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const PersonNameField({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onAdd,
    this.controller,
    this.validator,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 14.r,
            ),
            SizedBox(width: 3.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 6.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.black),
              onPressed: onAdd,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
          child: SizedBox(
            width: 350.w,
            height: 70.h,
            child: NewTextField(
              controller: controller,
              borderColor: errorText != null ? Colors.red : Colors.black,
              errorText: errorText,
              onChanged: onChanged,
              validator: validator, // Ensure the validator is applied
            ),
          ),
        ),
      ],
    );
  }
}
