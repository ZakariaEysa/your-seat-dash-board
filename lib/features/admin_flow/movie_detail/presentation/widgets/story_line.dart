import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/validators/Validators.dart';

class StoryLine extends StatefulWidget {
  const StoryLine({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController controller = TextEditingController();

  static bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  static void clearFields() {
    controller.clear();
    formKey.currentState?.reset();
  }

  @override
  State<StoryLine> createState() => _StoryLineState();
}

class _StoryLineState extends State<StoryLine> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: StoryLine.formKey,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 8.h, bottom: 28.h),
          child: NewTextField(
            controller: StoryLine.controller,
            hintText: '\n\n Write story line here ...',
            borderColor: _errorText != null ? Colors.red : Colors.black,
            errorText: _errorText,
            keyboardType: TextInputType.multiline,
            obscureText: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            errorStyle: TextStyle(fontSize: 12, color: Colors.red),
            isMultiline: true,
            maxLines: 5,
            validator: (value) {
              final error = Validators.validateRequired(
                value,
                'Story Line',
                maxLength: 50,
                lettersOnly: false,
              );
              setState(() {
                _errorText = error;
              });
              return _errorText;
            },
          ),
        ),
      ),
    );
  }
}