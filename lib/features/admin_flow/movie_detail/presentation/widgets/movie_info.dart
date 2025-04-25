import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';
import '../../../../../widgets/validators/Validators.dart';
import '../../../moives/data/movies_cubit/movies_cubit.dart';
import 'NewDropdownField.dart';
import 'logo&promo.dart';
import 'movie_text_field_label.dart';

class MovieInfoScreen extends StatefulWidget {
  final Map<String, dynamic> movieData;
  final bool isViewOnly;

  const MovieInfoScreen({
    Key? key,
    required this.movieData,
    this.isViewOnly = false,
  }) : super(key: key);

  @override
  MovieInfoScreenState createState() => MovieInfoScreenState();
}

class MovieInfoScreenState extends State<MovieInfoScreen> {
  static const Color errorColor = Color(0xFFE53935);





  String? _movieNameError;
  String? _durationError;
  String? _movieGenreError;
  String? _languageError;
  String? _censorshipError;
  String? _statusError;
  String? _promoLinkError;

  PlatformFile? pickedCover;
  String promoUrl = ''; // Initialized to empty string for the hintText to show

  final List<String> genreOptions = [
    'Action', 'Comedy', 'Drama', 'Horror', 'Adventure', 'Romance', 'Sci-Fi',
    'Fantasy', 'Thriller', 'Animation', 'Documentary', 'Crime', 'Mystery',
    'Biography', 'Musical'
  ];

  final List<String> languageOptions = [
    'English', 'Arabic', 'French', 'Spanish', 'German', 'Hindi',
    'Japanese', 'Korean', 'Chinese', 'Turkish'
  ];

  final List<String> censorshipOptions = [
    'tv-ma', 'tv-14', 'R', 'TV-PG', 'PG-13', 'PG', 'TV-Y7', 'TV-G', 'G', 'NC-17',
  ];

  final List<String> statusOptions = ['Playing now', 'Coming soon'];

  @override
  void initState() {
    super.initState();

    final movie = widget.movieData;
    MovieCubit.get(context).movieNameController.text = movie['name'] ?? '';
    MovieCubit.get(context).durationController.text = movie['date'] ?? '';

    // Here we set promoUrl to empty string so the hintText will appear initially
    promoUrl = movie['promoUrl'] ?? '';
    MovieCubit.get(context).promoLinkController.text = promoUrl;

    MovieCubit.get(context).selectedGenre = genreOptions.contains(movie['genre']) ? movie['genre'] : null;
    MovieCubit.get(context).selectedLanguage = languageOptions.contains(movie['rooms']) ? movie['rooms'] : null;
    MovieCubit.get(context).selectedStatus = statusOptions.contains(movie['status']) ? movie['status'] : null;
    MovieCubit.get(context).selectedCensorship = censorshipOptions.contains(movie['censorship']) ? movie['censorship'] : null;
  }

  void handlePick(PlatformFile? file) {
    setState(() => pickedCover = file);
  }

  void handleDelete() {
    setState(() => pickedCover = null);
  }

  bool validateFields() {
    setState(() {
      _movieNameError = Validators.validateRequired(
          MovieCubit.get(context).movieNameController.text, 'Movie name',
          lettersOnly: true, allowSpaces: true);
      _durationError = Validators.validateDurationFormat(MovieCubit.get(context).durationController.text);
      _movieGenreError = Validators.validateRequired(MovieCubit.get(context).selectedGenre, 'Movie genre');
      _languageError = Validators.validateRequired(MovieCubit.get(context).selectedLanguage, 'Language');
      _censorshipError = Validators.validateRequired(MovieCubit.get(context).selectedCensorship, 'Censorship');
      _statusError = Validators.validateRequired(MovieCubit.get(context).selectedStatus, 'Status');
      _promoLinkError = Validators.validateYouTubeLink(MovieCubit.get(context).promoLinkController.text);
    });

    return _movieNameError == null &&
        _durationError == null &&
        _movieGenreError == null &&
        _languageError == null &&
        _censorshipError == null &&
        _statusError == null &&
        _promoLinkError == null;
  }

  @override
  void dispose() {
    MovieCubit.get(context).movieNameController.dispose();
    MovieCubit.get(context).durationController.dispose();
    MovieCubit.get(context).promoLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
      child: IgnorePointer(
        ignoring: widget.isViewOnly,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MovieTextFieldLabel(
                                label: "Movie Name",
                                hintText: "Avengers",
                                controller: MovieCubit.get(context).movieNameController,
                                errorText: _movieNameError,
                                errorColor: errorColor,
                                onChanged: (value) {
                                  setState(() {
                                    _movieNameError = Validators.validateRequired(
                                      value,
                                      'Movie name',
                                      lettersOnly: true,
                                      allowSpaces: true,
                                    );
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: MovieTextFieldLabel(
                                label: "Duration",
                                hintText: "2h 10m",
                                controller: MovieCubit.get(context).durationController,
                                errorText: _durationError,
                                errorColor: errorColor,
                                onChanged: (value) {
                                  setState(() {
                                    _durationError = Validators.validateDurationFormat(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Language", style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                  SizedBox(height: 4.h),
                                  NewDropdownField(
                                    value: MovieCubit.get(context).selectedLanguage,
                                    items: languageOptions,
                                    hintText: 'English',
                                    errorText: _languageError,
                                    errorColor: errorColor,
                                    onChanged: (value) {
                                      setState(() {
                                        MovieCubit.get(context).selectedLanguage = value;
                                        _languageError = Validators.validateRequired(value, 'Language');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Censorship", style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                  SizedBox(height: 4.h),
                                  NewDropdownField(
                                    value: MovieCubit.get(context).selectedCensorship,
                                    items: censorshipOptions,
                                    hintText: 'TV-Y7',
                                    errorText: _censorshipError,
                                    errorColor: errorColor,
                                    onChanged: (value) {
                                      setState(() {
                                        MovieCubit.get(context).selectedCensorship = value;
                                        _censorshipError = Validators.validateRequired(value, 'Censorship');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Status", style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                  SizedBox(height: 4.h),
                                  NewDropdownField(
                                    value: MovieCubit.get(context).selectedStatus,
                                    items: statusOptions,
                                    hintText: 'Coming soon',
                                    errorText: _statusError,
                                    errorColor: errorColor,
                                    onChanged: (value) {
                                      setState(() {
                                        MovieCubit.get(context).selectedStatus = value;
                                        _statusError = Validators.validateRequired(value, 'Status');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Movie Genre", style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                                  SizedBox(height: 4.h),
                                  NewDropdownField(
                                    value: MovieCubit.get(context).selectedGenre,
                                    items: genreOptions,
                                    hintText: 'Action, adventure, sci-fi',
                                    errorText: _movieGenreError,
                                    errorColor: errorColor,
                                    onChanged: (value) {
                                      setState(() {
                                        MovieCubit.get(context).selectedGenre = value;
                                        _movieGenreError = Validators.validateRequired(value, 'Movie genre');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: LogoandPromo(
                      pickedCover: pickedCover,
                      onPick: handlePick,
                      onDelete: handleDelete,
                      promoLinkController: MovieCubit.get(context).promoLinkController,
                      promoLinkError: _promoLinkError,
                      errorColor: errorColor,
                      onLinkChanged: (value) {
                        setState(() {
                          _promoLinkError = Validators.validateYouTubeLink(value);
                          promoUrl = value;
                        });
                      },
                    ),
                  ),



                ],
              ),
            ],
          ),
        ),
      ),
    );

  }


}

