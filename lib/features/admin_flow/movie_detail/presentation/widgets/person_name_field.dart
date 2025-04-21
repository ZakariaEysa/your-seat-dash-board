import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/validators/Validators.dart';

class PersonNameField extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback? onAdd;
  final VoidCallback? onDelete;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool isViewOnly;

  const PersonNameField({
    Key? key,
    required this.label,
    required this.imagePath,
    this.onAdd,
    this.onDelete,
    this.controller,
    this.validator,
    this.errorText,
    this.onChanged,
    this.isViewOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Image + Label + Actions)
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 14.r,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 6.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              if (!isViewOnly && onAdd != null)
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: onAdd,
                  tooltip: 'Add $label',
                ),
              if (!isViewOnly && onDelete != null)
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: 'Remove $label',
                ),
            ],
          ),

          // Text Field
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
            child: SizedBox(
              width: double.infinity,
              height: 70.h,
              child:NewTextField(
                controller: controller,
                keyboardType: TextInputType.text,
                borderColor: isViewOnly
                    ? Colors.grey[400]!
                    : (errorText != null ? Colors.red : Colors.black),
                errorText: isViewOnly ? null : errorText,
                onChanged: onChanged,
                validator: isViewOnly ? null : validator,
                enabled: true,
                readOnly: isViewOnly,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isViewOnly ?Colors.black : (errorText != null ? Colors.red : Colors.black),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isViewOnly ?Colors.black : (errorText != null ? Colors.red : Colors.black),
                    width: 1.5,
                  ),
                ),
              )


            ),
          ),
        ],
      ),
    );
  }
}
