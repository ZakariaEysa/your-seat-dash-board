import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewDropdownField extends StatelessWidget {
  final String? value;
  final bool isEnabled;
  final List<String> items;
  final String? errorText;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final Color errorColor;

  const NewDropdownField({
    Key? key,
    this.value,
    this.isEnabled = true,
    required this.items,
    required this.hintText,
    this.errorText,
    this.onChanged,
    this.errorColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 5.sp, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      onChanged: isEnabled ? onChanged : null,
      dropdownColor: Colors.white,
      style: TextStyle(fontSize: 5.sp, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 5.sp, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor, width: 1.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: 4.sp,
          height: 0.5,
          color: errorColor,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          size: 10.sp,
          color: Colors.black,
        ),
      ),
      icon: const SizedBox(),
    );
  }
}
