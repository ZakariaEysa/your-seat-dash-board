import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/widgets/person_name_field.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/validators/Validators.dart';

class Names extends StatefulWidget {
  const Names({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  List<Widget> directorTextFields = [];
  List<Widget> actorTextFields = [];

  final List<TextEditingController> _directorControllers = [];
  final List<TextEditingController> _actorControllers = [];

  @override
  void initState() {
    super.initState();
    _addDirectorField();
    _addActorField();
  }

  void _addDirectorField() {
    final controller = TextEditingController();
    _directorControllers.add(controller);
    setState(() {
      directorTextFields.add(
        PersonNameField(
          label: 'Director Name',
          imagePath: 'assets/images/director.png',
          onAdd: _addDirectorField,
          controller: controller,
          validator: (value) => Validators.validateRequired(
            value,
            'Director Name',
            lettersOnly: true,
            maxLength: 20,
          ),
        ),
      );
    });
  }

  void _addActorField() {
    final controller = TextEditingController();
    _actorControllers.add(controller);
    setState(() {
      actorTextFields.add(
        PersonNameField(
          label: 'Actor Name',
          imagePath: 'assets/images/director.png',
          onAdd: _addActorField,
          controller: controller,
          validator: (value) => Validators.validateRequired(
            value,
            'Actor Name',
            lettersOnly: true,
            maxLength: 20,
          ),
        ),
      );
    });
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...directorTextFields],
                ),
              ),
              SizedBox(width: 20.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...actorTextFields],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
