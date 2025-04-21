import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/validators/Validators.dart';
import 'MovieInfoController.dart';
import 'NewDropdownField.dart';
import 'movie_text_field_label.dart';

class MovieInfoFields extends StatelessWidget {
  final MovieInfoController controller;
  final bool isViewOnly;
  final Color errorColor;

  const MovieInfoFields({
    Key? key,
    required this.controller,
    required this.isViewOnly,
    required this.errorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MovieTextFieldLabel(
                label: "Movie Name",
                hintText: "Avengers",
                controller: controller.movieNameController,
                errorText: controller.movieNameError,
                errorColor: errorColor,
                readOnly: isViewOnly,
                onChanged: (value) {
                  controller.movieNameError = Validators.validateRequired(
                    value,
                    'Movie name',
                    lettersOnly: true,
                    allowSpaces: true,
                  );
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: MovieTextFieldLabel(
                label: "Duration",
                hintText: "2h 10m",
                controller: controller.durationController,
                errorText: controller.durationError,
                errorColor: errorColor,
                readOnly: isViewOnly,
                onChanged: (value) {
                  controller.durationError =
                      Validators.validateDurationFormat(value);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: _buildDropdownSection(
                label: "Language",
                value: controller.selectedLanguage,
                items: controller.languageOptions,
                hintText: 'English',
                errorText: controller.languageError,
                onChanged: isViewOnly
                    ? null
                    : (value) {
                  controller.selectedLanguage = value;
                  controller.languageError = Validators.validateRequired(
                      value, 'Language');
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildDropdownSection(
                label: "Censorship",
                value: controller.selectedCensorship,
                items: controller.censorshipOptions,
                hintText: 'TV-Y7',
                errorText: controller.censorshipError,
                onChanged: isViewOnly
                    ? null
                    : (value) {
                  controller.selectedCensorship = value;
                  controller.censorshipError =
                      Validators.validateRequired(value, 'Censorship');
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: _buildDropdownSection(
                label: "Status",
                value: controller.selectedStatus,
                items: controller.statusOptions,
                hintText: 'Coming soon',
                errorText: controller.statusError,
                onChanged: isViewOnly
                    ? null
                    : (value) {
                  controller.selectedStatus = value;
                  controller.statusError =
                      Validators.validateRequired(value, 'Status');
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildDropdownSection(
                label: "Movie Genre",
                value: controller.selectedGenre,
                items: controller.genreOptions,
                hintText: 'Action, adventure, sci-fi',
                errorText: controller.movieGenreError,
                onChanged: isViewOnly
                    ? null
                    : (value) {
                  controller.selectedGenre = value;
                  controller.movieGenreError =
                      Validators.validateRequired(value, 'Movie genre');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownSection({
    required String label,
    required String? value,
    required List<String> items,
    required String hintText,
    required String? errorText,
    required ValueChanged<String?>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 6.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4.h),
        NewDropdownField(
          value: value,
          items: items,
          hintText: hintText,
          errorText: errorText,
          errorColor: errorColor,
          onChanged: onChanged,
          isEnabled: !isViewOnly,
        ),
      ],
    );
  }
}
