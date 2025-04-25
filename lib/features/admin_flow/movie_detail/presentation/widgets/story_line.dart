import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';
import '../../../../../widgets/validators/Validators.dart';

class StoryLine extends StatefulWidget {
  const StoryLine({
    super.key,
    this.initialValue = '',
    this.readOnly = false,
  });

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController controller = TextEditingController();
  final String initialValue;
  final bool readOnly;

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
  @override
  void initState() {
    super.initState();
    StoryLine.controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: StoryLine.formKey,
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(left: 30.w, right: 30.w, top: 8.h, bottom: 28.h),
          child: NewTextField(
            controller: StoryLine.controller,
            hintText: '\n\n Write story line here ...',
            borderColor: Colors.black,
            errorText: null,
            keyboardType: TextInputType.multiline,
            obscureText: false,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
            isMultiline: true,
            maxLines: 5,
            readOnly: widget.readOnly,
            onChanged: (_) {},
            validator: (value) {
              if (widget.readOnly) return null;
              return Validators.validateAnyText(
                value ?? '',
                'Story Line',
                maxLength: 1000,
                //lettersOnly: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
