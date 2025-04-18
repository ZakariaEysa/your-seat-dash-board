import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';

class MovieImageSection extends StatelessWidget {
  final PlatformFile? pickedCover;
  final Function(PlatformFile?) onPick;
  final VoidCallback onDelete;

  const MovieImageSection({
    super.key,
    required this.pickedCover,
    required this.onPick,
    required this.onDelete,
  });

  Future<void> pickCover() async {
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
        Container(
          width: 50.w,
          height: 130.h,
          color: Colors.grey[300],
          child: pickedCover != null
              ? Image.memory(pickedCover!.bytes!, fit: BoxFit.cover)
              : Image.asset("assets/images/avatar_film.png", fit: BoxFit.cover),
        ),
        SizedBox(height: 25.h),
        Row(
          children: [
            SizedBox(width: 5.w),
            ButtonBuilder(
              text: pickedCover == null ? 'Upload' : 'Change',
              onTap: () => pickCover(),
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
            TextButton(
              onPressed: onDelete,
              child: Text(
                'Delete',
                style: TextStyle(
                  color: const Color(0xFFFF0000),
                  fontSize: 4.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        // if (pickedCover != null) ...[
        //   SizedBox(height: 5.h),
        //   Text("🖼 ${pickedCover!.name}",
        //       style: TextStyle(fontSize: 4.sp, color: Colors.black), overflow: TextOverflow.ellipsis),
        //   Text("Size: ${(pickedCover!.size / 1024).toStringAsFixed(2)} KB",
        //       style: TextStyle(fontSize: 3.sp, color: Colors.black)),
        // ]
      ],
    );
  }
}
