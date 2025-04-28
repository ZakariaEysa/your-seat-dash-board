import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../widgets/cinema_design/Description_cinema.dart';
import '../widgets/cinema_design/cover_section.dart';
import '../widgets/cinema_design/pdf_section.dart';
import '../widgets/cinema_design/save_cancel_button.dart';

class CinemaDesign extends StatefulWidget {


  const CinemaDesign({super.key});

  @override
  State<CinemaDesign> createState() => _CinemaDesignState();

}

class _CinemaDesignState extends State<CinemaDesign> {
  final GlobalKey<DescriptionCinemaState> _descriptionKey = GlobalKey<DescriptionCinemaState>();

  PlatformFile? pickedPdf;
  PlatformFile? pickedCover;

  PlatformFile? previousPdf;
  PlatformFile? previousCover;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      fetchLastUploadedPdf(),
      fetchLastUploadedCover(),
      Future.delayed(Duration(seconds: 3)),
    ]);

    setState(() {
      isLoading = false;
    });
  }

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

  Future<void> fetchLastUploadedPdf() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('cinema_design')  // Remove inner "cinema_design"
          .collection('uploadedFiles')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        final String fileName = data['fileName'];
        final int fileSize = data['fileSize'];

        setState(() {
          pickedPdf = PlatformFile(
            name: fileName,
            size: fileSize,
            bytes: null,
            path: null,
          );
        });
      }
    } catch (e) {
      print("⚠️ خطأ أثناء جلب الملف: $e");
    }
  }

  Future<void> fetchLastUploadedCover() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('cinema_design')  // Remove inner "cinema_design"
          .collection('uploadedCovers')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        final String coverName = data['coverName'];
        final int coverSize = data['coverSize'];
        final String base64Content = data['coverContent'];

        Uint8List bytes = base64Decode(base64Content);

        setState(() {
          pickedCover = PlatformFile(
            name: coverName,
            size: coverSize,
            bytes: bytes,
            path: null,
          );
        });
      }
    } catch (e) {
      print("⚠️ فشل تحميل الصورة: $e");
    }
  }


  void uploadCoverToFirestoreWeb() async {
    if (pickedCover == null || pickedCover!.bytes == null) {
      print("⚠️ لا يوجد صورة.");
      return;
    }

    try {
      String base64Cover = base64Encode(pickedCover!.bytes!);

      final coverInfo = {
        'coverName': pickedCover!.name,
        'coverSize': pickedCover!.size,
        'coverContent': base64Cover,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('cinema_design')  // Removed inner "cinema_design"
          .collection('uploadedCovers')
          .add(coverInfo);

      print("✅ تم رفع الصورة بنجاح إلى Firestore!");
    } catch (e) {
      print("❌ فشل رفع الصورة.");
      print("🛠️ الخطأ: $e");
    }
  }
  void uploadToFirestoreWeb() async {
    if (pickedPdf == null || pickedPdf!.bytes == null) {
      print("⚠️ لا يوجد ملف PDF.");
      return;
    }

    try {
      String base64Content = base64Encode(pickedPdf!.bytes!);

      final fileInfo = {
        'fileName': pickedPdf!.name,
        'fileSize': pickedPdf!.size,
        'fileContent': base64Content,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('cinema_design')  // Removed inner "cinema_design"

          .collection('uploadedFiles')
          .add(fileInfo);

      print("✅ تم رفع الملف بنجاح إلى Firestore!");
    } catch (e) {
      print("❌ فشل رفع الملف.");
      print("🛠️ الخطأ: $e");
    }
  }

  void saveFiles() {
    final descriptionText = _descriptionKey.currentState?.descriptionText ?? '';

    if (pickedPdf == null || pickedCover == null || descriptionText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload all required files and fill cinema description❗', style: TextStyle(fontSize:3.sp)),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      uploadToFirestoreWeb();
      uploadCoverToFirestoreWeb();
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
      body: isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20.h),
          ],
        ),
      )
          : Center(
        child: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: SingleChildScrollView(
            child: Container(
              width: 880.w,
              height: 700.h,
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
                            onPick: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                                withData: true,
                              );
                              if (result != null && result.files.single.bytes != null) {
                                setState(() {
                                  pickedPdf = result.files.single;
                                });
                              }
                            },
                            onDelete: () {
                              setState(() {
                                pickedPdf = null;
                              });
                            },
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
                  padding: EdgeInsets.only(top: 90.h, left: 40.w),child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [ Text("Description Cinema",style: TextStyle(
                  color: Colors.black,
                  fontSize: 5.sp
                ),), DescriptionCinema(
                  key: _descriptionKey, // هنا ضفنا المفتاح
                  width: 180.w,
                  height: 100.h,
                  hintText: 'Write your cinema description here',
                ),
                ]),),

                    Padding(
                      padding: EdgeInsets.only(top: 100.h, right: 20.w),
                      child: Row(
                        children: [
                          SaveCancelButtons(
                            onSave: saveFiles,
                            onCancel: cancelChanges,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
