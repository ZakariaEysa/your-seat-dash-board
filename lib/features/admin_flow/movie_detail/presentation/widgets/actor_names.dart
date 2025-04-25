import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../widgets/validators/Validators.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';

class ActorNames extends StatefulWidget {
  const ActorNames({
    super.key,
    required this.actors,
    this.isViewOnly = false,
  });

  final List<String> actors;
  final bool isViewOnly;

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  State<ActorNames> createState() => _ActorNamesState();
}

class _ActorNamesState extends State<ActorNames> {
  late List<TextEditingController> _controllers;
  List<PlatformFile?> _pickedImages = [];

  @override
  void initState() {
    super.initState();
    _controllers = widget.actors.map((name) => TextEditingController(text: name)).toList();
    _pickedImages = List.generate(_controllers.length, (_) => null);

    if (_controllers.isEmpty) _addActorField();
  }

  void _addActorField() {
    _controllers.add(TextEditingController());
    _pickedImages.add(null);
    setState(() {});
  }

  void _removeActorField(int index) {
    if (_controllers.length > 1) {
      _controllers.removeAt(index);
      _pickedImages.removeAt(index);
      setState(() {});
    }
  }

  Future<void> _pickImage(int index) async {
    if (widget.isViewOnly) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pickedImages[index] = result.files.single;
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _pickedImages[index] = null;
    });
  }

  Widget _buildActorFields() {
    List<Widget> rows = [];
    for (int i = 0; i < _controllers.length; i += 2) {
      final hasSecond = i + 1 < _controllers.length;

      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PersonNameField(
              label: 'Actor Name',
              controller: _controllers[i],
              imageBytes: _pickedImages[i]?.bytes,
              onAdd: widget.isViewOnly ? null : _addActorField,
              onDelete: widget.isViewOnly || i == 0 ? null : () => _removeActorField(i),
              onUpload: () => _pickImage(i),
              onDeleteImage: () => _deleteImage(i),
              validator: (value) => Validators.validateRequired(
                value,
                'Actor Name',
                lettersOnly: true,
                maxLength: 50,
              ),
              isViewOnly: widget.isViewOnly,
              isFirst: i == 0,
            ),
          ),
          SizedBox(width: 10.w),
          if (hasSecond)
            Expanded(
              child: PersonNameField(
                label: 'Actor Name',
                controller: _controllers[i + 1],
                imageBytes: _pickedImages[i + 1]?.bytes,
                onAdd: null,
                onDelete: widget.isViewOnly ? null : () => _removeActorField(i + 1),
                onUpload: () => _pickImage(i + 1),
                onDeleteImage: () => _deleteImage(i + 1),
                validator: (value) => Validators.validateRequired(
                  value,
                  'Actor Name',
                  lettersOnly: true,
                  maxLength: 50,
                ),
                isViewOnly: widget.isViewOnly,
                isFirst: false,
              ),
            )
          else
            Expanded(child: Container()),
        ],
      ));

      rows.add(SizedBox(height: 10.h));
    }

    return Column(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ActorNames.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 62.w, vertical: 15.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(10.sp),
          child: _buildActorFields(),
        ),
      ),
    );
  }
}
