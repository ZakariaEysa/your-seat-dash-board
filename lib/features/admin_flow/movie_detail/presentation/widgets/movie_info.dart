import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/validators/Validators.dart';
import 'movie_text_field_label.dart';
import 'movie_image.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({Key? key}) : super(key: key);

  @override
  MovieInfoScreenState createState() => MovieInfoScreenState();
}

class MovieInfoScreenState extends State<MovieInfoScreen> {
  final TextEditingController _movieNameController = TextEditingController();
  final TextEditingController _movieGenreController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _censorshipController = TextEditingController();

  String? _movieNameError;
  String? _movieGenreError;
  String? _languageError;
  String? _censorshipError;

  bool validateFields() {
    setState(() {
      _movieNameError = Validators.validateRequired(
        _movieNameController.text,
        'Movie name',
      );
      _movieGenreError = Validators.validateRequired(
        _movieGenreController.text,
        'Movie genre',
      );
      _languageError = Validators.validateRequired(
        _languageController.text,
        'Language',
      );
      _censorshipError = Validators.validateRequired(
        _censorshipController.text,
        'Censorship',
      );
    });

    return _movieNameError == null &&
        _movieGenreError == null &&
        _languageError == null &&
        _censorshipError == null;
  }

  void _onFieldChanged(
      String value, Function(String?) setError, String fieldName) {
    if (_movieNameError != null ||
        _movieGenreError != null ||
        _languageError != null ||
        _censorshipError != null) {
      setState(() {
        setError(Validators.validateRequired(value, fieldName));
      });
    }
  }

  @override
  void dispose() {
    _movieNameController.dispose();
    _movieGenreController.dispose();
    _languageController.dispose();
    _censorshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      height: 295.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.only(top: 30.h, left: 10.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieTextFieldLabel(
                  label: "Movie Name",
                  controller: _movieNameController,
                  errorText: _movieNameError,
                  onChanged: (value) => _onFieldChanged(
                    value,
                        (error) => _movieNameError = error,
                    'Movie name',
                  ),
                ),
                SizedBox(height: 15.h),
                MovieTextFieldLabel(
                  label: "Language",
                  controller: _languageController,
                  errorText: _languageError,
                  onChanged: (value) => _onFieldChanged(
                    value,
                        (error) => _languageError = error,
                    'Language',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieTextFieldLabel(
                  label: "Movie Genre",
                  controller: _movieGenreController,
                  errorText: _movieGenreError,
                  onChanged: (value) => _onFieldChanged(
                    value,
                        (error) => _movieGenreError = error,
                    'Movie genre',
                  ),
                ),
                SizedBox(height: 15.h),
                MovieTextFieldLabel(
                  label: "Censorship",
                  controller: _censorshipController,
                  errorText: _censorshipError,
                  onChanged: (value) => _onFieldChanged(
                    value,
                        (error) => _censorshipError = error,
                    'Censorship',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          const Expanded(child: MovieImageSection()),
        ],
      ),
    );
  }
}
