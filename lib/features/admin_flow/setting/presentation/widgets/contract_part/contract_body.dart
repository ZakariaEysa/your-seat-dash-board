import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../widgets/button/button_builder.dart';
import 'contract_file_info.dart';
import 'contract_buttons.dart';

class ContractBody extends StatefulWidget {
  const ContractBody({super.key});

  @override
  State<ContractBody> createState() => _ContractBodyState();
}

class _ContractBodyState extends State<ContractBody> {
  PlatformFile? selectedFile;
  PlatformFile? previousFile;
  PlatformFile? uploadedFile; // ✅ الملف اللي جاي من فايرستور
  bool isLoading = false; // ✅ متغير لتحديد حالة التحميل

  @override
  void initState() {
    super.initState();
    fetchUploadedFile(); // ✅ تحميل الملف أول ما تفتح الصفحة
  }

  // ✅ رفع ملف PDF إلى Firestore
  Future<void> uploadToFirestoreWeb() async {
    if (selectedFile == null || selectedFile!.bytes == null) {
      print("⚠️ لا يوجد ملف PDF.");
      return;
    }

    try {
      setState(() {
        isLoading = true; // ✅ بدء التحميل
      });

      String base64Content = base64Encode(selectedFile!.bytes!);

      final fileInfo = {
        'fileName': selectedFile!.name,
        'fileSize': selectedFile!.size,
        'fileContent': base64Content,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('contract')
          .collection('uploadedFiles')
          .add(fileInfo);

      print("✅ تم رفع الملف بنجاح إلى Firestore!");
    } catch (e) {
      print("❌ فشل رفع الملف.");
      print("🛠️ الخطأ: $e");
    } finally {
      setState(() {
        isLoading = false; // ✅ إيقاف التحميل بعد الانتهاء
      });
    }
  }

  // ✅ تحميل الملف الأخير من Firestore وتخزينه محليًا
  Future<void> fetchUploadedFile() async {
    try {
      setState(() {
        isLoading = true; // ✅ بدء التحميل
      });

      final snapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('contract')
          .collection('uploadedFiles')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        print("❌ لا يوجد ملفات.");
        return;
      }

      final data = snapshot.docs.first.data();
      String fileName = data['fileName'];
      String base64Content = data['fileContent'];
      Uint8List fileBytes = base64Decode(base64Content);

      setState(() {
        uploadedFile = PlatformFile(
          name: fileName,
          size: fileBytes.length,
          bytes: fileBytes,
        );
      });
    } catch (e) {
      print("❌ حدث خطأ أثناء تحميل الملف من فايرستور: $e");
    } finally {
      setState(() {
        isLoading = false; // ✅ إيقاف التحميل بعد الانتهاء
      });
    }
  }

  // ✅ تحميل الملف وفتحه للمستخدم
  Future<void> downloadPdfFromFirestore() async {
    try {
      setState(() {
        isLoading = true; // ✅ بدء التحميل
      });

      final snapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc('contract')
          .collection('uploadedFiles')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        print("❌ لا يوجد ملفات.");
        return;
      }

      final data = snapshot.docs.first.data();
      String fileName = data['fileName'];
      String base64Content = data['fileContent'];
      Uint8List fileBytes = base64Decode(base64Content);

      final blob = html.Blob([fileBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();

      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ تم تحميل الملف: $fileName')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ حدث خطأ أثناء التحميل: $e')),
      );
    } finally {
      setState(() {
        isLoading = false; // ✅ إيقاف التحميل بعد الانتهاء
      });
    }
  }

  // ✅ اختيار ملف من الجهاز
  Future<void> uploadContract(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        previousFile = selectedFile;
        selectedFile = result.files.single;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📄 تم اختيار الملف: ${selectedFile!.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم اختيار أي ملف.')),
      );
    }
  }

  // ✅ إلغاء التعديلات
  void cancelChanges() {
    if (selectedFile != previousFile) {
      setState(() {
        selectedFile = previousFile;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الإلغاء ❌')),
      );
    }
  }

  // ✅ حفظ التعديلات
  void saveChanges() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار ملف أولًا ❗')),
      );
      return;
    }

    await uploadToFirestoreWeb();

    await fetchUploadedFile(); // ✅ بعد الحفظ مباشرة جيب آخر ملف وحدث الشاشة

    setState(() {
      previousFile = selectedFile;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم الحفظ ورفع الملف ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 700.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
        child: SingleChildScrollView( // ✅ أضفنا Scroll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contract info",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 8.sp,
                ),
              ),
              Text(
                "Update your Contract info here",
                style: TextStyle(color: Color(0xFF625C5C), fontSize: 5.sp),
              ),
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Download Contract',
                    onTap: () => downloadPdfFromFirestore(),
                    width: 86.w,
                    height: 78.h,
                    buttonColor: const Color(0xFFF3F3F3),
                    frameColor: const Color(0xFFEB68E3),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.sp,
                    ),
                  ),
                  SizedBox(width: 40.w),
                  ButtonBuilder(
                    text: selectedFile == null ? 'Upload Contract' : 'Change File',
                    onTap: () => uploadContract(context),
                    width: 86.w,
                    height: 78.h,
                    buttonColor: const Color(0xFFF3F3F3),
                    frameColor: const Color(0xFFEB68E3),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              if (isLoading)
                Center(child: CircularProgressIndicator()) // ✅ إظهار لودينج
              else if (uploadedFile != null)
                ContractFileInfo(file: uploadedFile!)
              else if (selectedFile != null)
                  ContractFileInfo(file: selectedFile!),

              ContractButtons(
                onSave: saveChanges,
                onCancel: cancelChanges,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
