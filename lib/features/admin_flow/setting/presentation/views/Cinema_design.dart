import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/cinema_design/cover_section.dart';
import '../widgets/cinema_design/pdf_section.dart';
import '../widgets/cinema_design/save_cancel_button.dart';


class CinemaDesign extends StatefulWidget {
  const CinemaDesign({super.key});

  @override
  State<CinemaDesign> createState() => _CinemaDesignState();
}

class _CinemaDesignState extends State<CinemaDesign> {
  PlatformFile? pickedPdf;
  PlatformFile? pickedCover;

  PlatformFile? previousPdf;
  PlatformFile? previousCover;

  void setPickedPdf(PlatformFile? file) {
    setState(() {
      previousPdf = pickedPdf;
      pickedPdf = file;
    });
  }

  void setPickedCover(PlatformFile? file) {
    setState(() {
      previousCover = pickedCover;
      pickedCover = file;
    });
  }

  void cancelChanges() {
    bool wasChanged = pickedPdf != previousPdf || pickedCover != previousCover;
    setState(() {
      pickedPdf = previousPdf;
      pickedCover = previousCover;
    });
    if (wasChanged) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الإلغاء ❌')),
      );
    }
  }

  void saveFiles() {
    if (pickedPdf == null || pickedCover == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload all required files❗', style: TextStyle(fontSize: 4.sp)),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      previousPdf = pickedPdf;
      previousCover = pickedCover;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved ✅', style: TextStyle(fontSize: 4.sp)),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Container(
            width: 880.w,
            height: 668.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 40.h, left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("update Cinema Tax Register here",
                      style: TextStyle(color: const Color(0xFF6A6767), fontSize: 5.sp)),
                  SizedBox(height: 50.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PDFSection(
                          pickedPdf: pickedPdf,
                          onPick: setPickedPdf,
                          onDelete: () => setPickedPdf(null),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: CoverSection(
                          pickedCover: pickedCover,
                          onPick: setPickedCover,
                          onDelete: () => setPickedCover(null),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.h, right: 20.w),
                    child: SaveCancelButtons(
                      onSave: saveFiles,
                      onCancel: cancelChanges,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
