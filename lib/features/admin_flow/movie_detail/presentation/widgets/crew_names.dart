import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
import '../../../../../widgets/validators/Validators.dart';

///////////////////////////////////////////////////////////////////////////////////////////////////
//-----------------------   class for director,writer and producer    ---------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////

class CrewNames extends StatefulWidget {
  const CrewNames({
    super.key,
    required this.directorName,
    required this.writerName,
    required this.producerName,
    this.isViewOnly = false,
  });

  final String directorName;
  final String writerName;
  final String producerName;
  final bool isViewOnly;

  static final GlobalKey<_CrewNamesState> crewKey =
      GlobalKey<_CrewNamesState>();

  bool validate() {
    return crewKey.currentState?._validateFields() ?? false;
  }

  @override
  _CrewNamesState createState() => _CrewNamesState();
}

class _CrewNamesState extends State<CrewNames> {
  late TextEditingController _directorController;
  late TextEditingController _writerController;
  late TextEditingController _producerController;
  Uint8List? _directorImage;
  Uint8List? _writerImage;
  Uint8List? _producerImage;
  String? _directorError;
  String? _writerError;
  String? _producerError;

  bool _validateFields() {
    setState(() {
      _directorError = Validators.validateRequired(
          _directorController.text, 'Director Name');
      _writerError =
          Validators.validateRequired(_writerController.text, 'Writer Name');
      _producerError = Validators.validateRequired(
          _producerController.text, 'Producer Name');
    });
    return _directorError == null &&
        _writerError == null &&
        _producerError == null;
  }

  @override
  void initState() {
    super.initState();
    _directorController = TextEditingController(text: widget.directorName);
    _writerController = TextEditingController(text: widget.writerName);
    _producerController = TextEditingController(text: widget.producerName);
  }

  @override
  void dispose() {
    _directorController.dispose();
    _writerController.dispose();
    _producerController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(Function(Uint8List?) setImage) async {
    if (widget.isViewOnly) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => setImage(bytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(7.sp),
        child: Row(
          children: [
            // Director
            SizedBox(
              width: 100.w,
              child: PersonNameField(
                label: 'Director Name',
                imageBytes: _directorImage,
                controller: _directorController,
                errorText: _directorError,
                validator: (value) =>
                    Validators.validateRequired(value, 'Director Name'),
                onUpload: () =>
                    _pickImage((img) => setState(() => _directorImage = img)),
                onDeleteImage: () => setState(() => _directorImage = null),
                isViewOnly: widget.isViewOnly,
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            // Writer
            SizedBox(
              width: 100.w,
              child: PersonNameField(
                label: 'Writer Name',
                imageBytes: _writerImage,
                controller: _writerController,
                errorText: _writerError,
                validator: (value) =>
                    Validators.validateRequired(value, 'Writer Name'),
                onUpload: () =>
                    _pickImage((img) => setState(() => _writerImage = img)),
                onDeleteImage: () => setState(() => _writerImage = null),
                isViewOnly: widget.isViewOnly,
              ),
            ),
            //   SizedBox(width: 3.w),
            SizedBox(
              width: 6.w,
            ),

            // Producer
            SizedBox(
              width: 100.w,
              child: PersonNameField(
                label: 'Producer Name',
                imageBytes: _producerImage,
                controller: _producerController,
                errorText: _producerError,
                validator: (value) =>
                    Validators.validateRequired(value, 'Producer Name'),
                onUpload: () =>
                    _pickImage((img) => setState(() => _producerImage = img)),
                onDeleteImage: () => setState(() => _producerImage = null),
                isViewOnly: widget.isViewOnly,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
