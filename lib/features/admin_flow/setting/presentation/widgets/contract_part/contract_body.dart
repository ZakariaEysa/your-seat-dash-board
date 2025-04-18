import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:html' as html;
import 'dart:typed_data';

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

  Future<void> downloadContract(BuildContext context) async {
    try {
      ByteData data = await rootBundle.load('assets/pdf/contract.pdf');
      final blob = html.Blob([data.buffer.asUint8List()]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "contract.pdf")
        ..click();
      html.Url.revokeObjectUrl(url);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Download started')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: ${e.toString()}')),
      );
    }
  }

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
        SnackBar(content: Text('📄 File selected: ${selectedFile!.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected.')),
      );
    }
  }

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


  void saveChanges() {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a contract file ❗')),
      );
      return;
    }

    previousFile = selectedFile;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Container(
        width: 300.w,
        height: 670.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 20.w),
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
                    onTap: () => downloadContract(context),
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
              if (selectedFile != null)
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
