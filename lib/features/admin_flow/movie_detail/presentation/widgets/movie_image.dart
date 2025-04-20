import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class MovieImageSection extends StatelessWidget {
  final PlatformFile? pickedCover;
  final Function(PlatformFile?) onPick;
  final VoidCallback onDelete;
  final TextEditingController promoLinkController;
  final String? promoLinkError;
  final Function(String)? onLinkChanged;
  final Color errorColor; // Added for consistent error styling

  const MovieImageSection({
    super.key,
    required this.pickedCover,
    required this.onPick,
    required this.onDelete,
    required this.promoLinkController,
    this.promoLinkError,
    this.onLinkChanged,
    this.errorColor = Colors.red, // Default error color
  });

  Future<void> pickCover() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true, // Ensure we get file bytes
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.bytes != null) {
          onPick(file);
        }
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Container with Error Border
        Container(
          width: 70.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: promoLinkError != null ? errorColor : Colors.grey,
              width: promoLinkError != null ? 1.5 : 1.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.r), // Slightly smaller than container
            child: pickedCover != null
                ? Image.memory(
              pickedCover!.bytes!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
                : Image.asset(
              "assets/images/avatar_film.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),

        SizedBox(height: 25.h),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Upload/Change Button
            ButtonBuilder(
              text: pickedCover == null ? 'Upload' : 'Change',
              onTap: pickCover,
              width: 33.w,
              height: 50.h,
              buttonColor: const Color(0xFF560B76),
              frameColor: const Color(0xFF560B76),
              borderShape: BorderRadius.circular(15.r),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 6.sp,
              ),
            ),

            SizedBox(width: 6.w),

            // Delete Button (always visible)
            ButtonBuilder(
              text: 'Delete',
              onTap: onDelete,
              width: 33.w,
              height: 50.h,
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

        // Promo Link Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                "Promo Link",
                style: TextStyle(
                  fontSize: 5.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 4.h),

            NewTextField(
              controller: promoLinkController,
              hintText: 'https://youtu.be/VIDEO_ID',
              keyboardType: TextInputType.url,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 17.h,
              ),
              borderColor: promoLinkError != null ? errorColor : Colors.black,
              errorColor: errorColor,
              errorText: promoLinkError,
              onChanged: onLinkChanged,
            ),
          ],
        ),
      ],
    );
  }
}
