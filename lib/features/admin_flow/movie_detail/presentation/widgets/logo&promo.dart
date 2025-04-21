import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/button/button_builder.dart';

class LogoandPromo extends StatelessWidget {
  final PlatformFile? pickedCover;
  final Function(PlatformFile?) onPick;
  final VoidCallback onDelete;
  final TextEditingController promoLinkController;
  final String? promoLinkError;
  final Color errorColor;
  final ValueChanged<String> onLinkChanged;
  final bool isViewOnly; // Added view-only mode support

  const LogoandPromo({
    super.key,
    required this.pickedCover,
    required this.onPick,
    required this.onDelete,
    required this.promoLinkController,
    required this.promoLinkError,
    required this.errorColor,
    required this.onLinkChanged,
    this.isViewOnly = false, // Default to false
  });

  Future<void> pickCover() async {
    if (isViewOnly) return; // Prevent picking in view-only mode

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      onPick(result.files.single);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Film Logo Text
        Padding(
          padding: EdgeInsets.only(right: 35.w),
          child: Text(
            "Film Logo",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 5.sp,
            ),
          ),
        ),
        SizedBox(height: 5.h),

        // Image Container
        Container(
          width: 60.w,
          height: 130.h,
          color: Colors.grey[300],
          child: pickedCover != null
              ? Image.memory(pickedCover!.bytes!, fit: BoxFit.cover)
              : Image.asset("assets/images/avatar_film.png", fit: BoxFit.cover),
        ),
        SizedBox(height: 25.h),

        // Buttons Row (only show if not in view-only mode)
        if (!isViewOnly) ...[
          Row(
            children: [
              SizedBox(width: 15.w),
              ButtonBuilder(
                text: pickedCover == null ? 'Upload' : 'Change',
                onTap: pickCover,
                width: 30.w,
                height: 51.h,
                buttonColor: const Color(0xFF560B76),
                frameColor: const Color(0xFF560B76),
                borderShape: BorderRadius.circular(15.r),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 6.sp,
                ),
              ),
              SizedBox(width: 2.w),
              ButtonBuilder(
                text: 'Delete',
                onTap: onDelete,
                width: 30.w,
                height: 51.h,
                buttonColor: const Color(0xFFFF0000),
                frameColor: const Color(0xFFFF0000),
                borderShape: BorderRadius.circular(15.r),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 6.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
        ],

        // Promo Link Section
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Promo Link',
                style: TextStyle(
                  fontSize: 5.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.h),
              NewTextField(
                controller: promoLinkController,
                readOnly: isViewOnly,
                onChanged: onLinkChanged,
                hintText: 'https://youtube/VEDIO_ID',
                errorText: isViewOnly ? null : promoLinkError,
                borderColor: isViewOnly
                    ? Colors.black
                    : (promoLinkError != null ? Colors.red : Colors.black),
              )



            ],
          ),
        ),
      ],
    );
  }
}