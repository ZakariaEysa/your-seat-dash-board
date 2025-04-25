import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
import '../../../../../widgets/validators/Validators.dart';

class ActorNames extends StatefulWidget {
  const ActorNames({
    super.key,
    required this.directors,
    required this.actors,
    this.isViewOnly = false,
  });

  final List<String> directors;
  final List<String> actors;
  final bool isViewOnly;

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  _ActorNamesState createState() => _ActorNamesState();
}

class _ActorNamesState extends State<ActorNames> {
  late List<TextEditingController> _actorControllers;
  List<PlatformFile?> _pickedImages = [];

  @override
  void initState() {
    super.initState();
    _actorControllers =
        widget.actors.map((name) => TextEditingController(text: name)).toList();
    _pickedImages = List.generate(_actorControllers.length, (_) => null);

    if (_actorControllers.isEmpty) _addActorField();
  }

  void _addActorField() {
    _actorControllers.add(TextEditingController());
    _pickedImages.add(null);
    setState(() {});
  }

  void _removeActorField(int index) {
    if (_actorControllers.length > 1) {
      _actorControllers.removeAt(index);
      _pickedImages.removeAt(index);
      setState(() {});
    }
  }

  Future<void> _pickImage(int index) async {
    if (widget.isViewOnly) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
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
    List<Widget> actorPairs = [];
    for (int i = 0; i < _actorControllers.length; i += 2) {
      bool hasPair = i + 1 < _actorControllers.length;

      actorPairs.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PersonNameField(
                label: 'Actor Name',
                imageBytes: _pickedImages[i]?.bytes,
                controller: _actorControllers[i],
                onAdd: widget.isViewOnly ? null : _addActorField,
                onDelete: widget.isViewOnly || i == 0
                    ? null
                    : () => _removeActorField(i),
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
            if (hasPair)
              Expanded(
                child: PersonNameField(
                  label: 'Actor Name',
                  imageBytes: _pickedImages[i + 1]?.bytes,
                  controller: _actorControllers[i + 1],
                  onAdd: null,
                  onDelete:
                      widget.isViewOnly ? null : () => _removeActorField(i + 1),
                  onUpload: () => _pickImage(i + 1),
                  onDeleteImage: () => _deleteImage(i + 1),
                  validator: (value) => Validators.validateRequired(
                    value,
                    'Actor Name',
                    lettersOnly: true,
                    maxLength: 20,
                  ),
                  isViewOnly: widget.isViewOnly,
                  isFirst: false,
                ),
              )
            else
              Expanded(child: Container()),
          ],
        ),
      );

      if (i + 2 < _actorControllers.length) {
        actorPairs.add(SizedBox(height: 0.h));
      }
    }

    return Column(
      children: actorPairs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ActorNames.formKey,
      child: Padding(
        padding: EdgeInsets.only(left:35.w,right: 35.w,top: 15.h,bottom: 25.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(9.sp),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: _buildActorFields(),
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}
