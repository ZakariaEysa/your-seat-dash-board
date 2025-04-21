import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
import '../../../../../widgets/validators/Validators.dart';

class Names extends StatefulWidget {
  const Names({
    super.key,
    required this.directors,
    required this.actors,
    this.isViewOnly = false, // ✅ إضافة المتغير
  });

  final List<String> directors;
  final List<String> actors;
  final bool isViewOnly; // ✅

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  late List<TextEditingController> _directorControllers;
  late List<TextEditingController> _actorControllers;

  @override
  void initState() {
    super.initState();
    _directorControllers = widget.directors.map((name) => TextEditingController(text: name)).toList();
    _actorControllers = widget.actors.map((name) => TextEditingController(text: name)).toList();

    if (_directorControllers.isEmpty) _addDirectorField();
    if (_actorControllers.isEmpty) _addActorField();
  }

  void _addDirectorField() {
    _directorControllers.add(TextEditingController());
    setState(() {});
  }

  void _removeDirectorField(int index) {
    if (_directorControllers.length > 1) {
      _directorControllers.removeAt(index);
      setState(() {});
    }
  }

  void _addActorField() {
    _actorControllers.add(TextEditingController());
    setState(() {});
  }

  void _removeActorField(int index) {
    if (_actorControllers.length > 1) {
      _actorControllers.removeAt(index);
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var controller in _directorControllers) {
      controller.dispose();
    }
    for (var controller in _actorControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildFields(
      List<TextEditingController> controllers,
      String label,
      String imagePath, {
        VoidCallback? onAdd,
        void Function(int)? onDelete,
      }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(controllers.length, (index) {
        return PersonNameField(
          label: label,
          imagePath: imagePath,
          controller: controllers[index],
          onAdd: widget.isViewOnly ? null : onAdd,
          onDelete: widget.isViewOnly || index == 0 ? null : () => onDelete?.call(index),
          validator: (value) => Validators.validateRequired(
            value,
            label,
            lettersOnly: true,
            maxLength: 20,
          ),
          isViewOnly: widget.isViewOnly,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Names.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: Container(
          width: 220.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(10.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFields(
                  _directorControllers,
                  'Director Name',
                  'assets/images/director.png',
                  onAdd: _addDirectorField,
                  onDelete: _removeDirectorField,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildFields(
                  _actorControllers,
                  'Actor Name',
                  'assets/images/director.png',
                  onAdd: _addActorField,
                  onDelete: _removeActorField,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
