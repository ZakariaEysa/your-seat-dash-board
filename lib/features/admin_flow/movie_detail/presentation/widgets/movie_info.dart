import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/validators/Validators.dart';
import '../../../moives/data/movies_cubit/movies_cubit.dart';
import 'NewDropdownField.dart';
import 'logo .dart';
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

  // Controllers
  // final TextEditingController _movieNameController = TextEditingController();
  // final TextEditingController _durationController = TextEditingController();
  // final TextEditingController _promoLinkController = TextEditingController();
  // final TextEditingController _versionController = TextEditingController();

  // Dropdown values
  String? selectedGenre;
  String? selectedLanguage;
  String? selectedCensorship;
  String? selectedStatus;

  // Validation errors
  String? _movieNameError;
  String? _durationError;
  String? _movieGenreError;
  String? _languageError;
  String? _censorshipError;
  String? _statusError;
  String? _promoLinkError;
  String? _versionError;

  // File handling
  PlatformFile? pickedCover;
  String promoUrl = '';

  // Options
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

    // Initialize from movie data
    MovieCubit.get(context).movieNameController.text = movie['name'] ?? '';
    MovieCubit.get(context).durationController.text = movie['duration'] ?? '';
    MovieCubit.get(context).versionController.text = movie['vresionnumber'] ?? '';
    promoUrl = movie['promoUrl'] ?? '';
    MovieCubit.get(context).promoLinkController.text = promoUrl;

    selectedGenre = genreOptions.contains(movie['genre']) ? movie['genre'] : null;
    selectedLanguage = languageOptions.contains(movie['language']) ? movie['language'] : null;
    selectedStatus = statusOptions.contains(movie['status']) ? movie['status'] : null;
    selectedCensorship = censorshipOptions.contains(movie['censorship']) ? movie['censorship'] : null;
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
        MovieCubit.get(context).movieNameController.text,
        'Movie name',
      );
      _durationError =   Validators.validateDurationFormat(MovieCubit.get(context).durationController.text);
      _movieGenreError = Validators.validateRequired(selectedGenre, 'Movie genre');
      _languageError = Validators.validateRequired(selectedLanguage, 'Language');
      _censorshipError = Validators.validateRequired(selectedCensorship, 'Censorship');
      _statusError = Validators.validateRequired(selectedStatus, 'Status');
      _promoLinkError = Validators.validateYouTubeLink(MovieCubit.get(context).promoLinkController.text);
      _versionError = Validators.validateVersionNumber(MovieCubit.get(context).versionController.text);
    });

    return _movieNameError == null &&
        _durationError == null &&
        _movieGenreError == null &&
        _languageError == null &&
        _censorshipError == null &&
        _statusError == null &&
        _promoLinkError == null &&
        _versionError == null;
  }

  @override
  void dispose() {
    // _movieNameController.dispose();
    // _durationController.dispose();
    // _promoLinkController.dispose();
    // _versionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.w, right: 22.w),
      child: Container(
        width: 200.w,
        height: 450.h,
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
                                      _movieNameError =
                                          Validators.validateRequired(
                                            value,
                                            'Movie name',
                                          );
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: MovieTextFieldLabel(
                                  label: "Duration",
                                  hintText: "120m",
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
                                child: MovieTextFieldLabel(
                                  label: "Promo Link",
                                  hintText: "https://youtube/VIDEO_ID",
                                  controller: MovieCubit.get(context).promoLinkController,
                                  errorText: _promoLinkError,
                                  errorColor: errorColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _promoLinkError = Validators.validateYouTubeLink(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: MovieTextFieldLabel(
                                  label: "Version Number",
                                  hintText: "YYYY-MM-DD",
                                  controller: MovieCubit.get(context).versionController,
                                  errorText: _versionError,
                                  errorColor: errorColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _versionError = Validators.validateVersionNumber(value);
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
                                    Text("Language",
                                        style: TextStyle(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: MovieCubit.get(context).selectedLanguage,
                                      items: languageOptions,
                                      hintText: 'English',
                                      errorText: _languageError,
                                      errorColor: errorColor,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedLanguage = value;
                                          MovieCubit.get(context).selectedLanguage = selectedLanguage;
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
                                    Text("Censorship",
                                        style: TextStyle(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: MovieCubit.get(context).selectedCensorship,
                                      items: censorshipOptions,
                                      hintText: 'TV-Y7',
                                      errorText: _censorshipError,
                                      errorColor: errorColor,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCensorship = value;
                                          MovieCubit.get(context).selectedCensorship = selectedCensorship;
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
                                    Text("Status",
                                        style: TextStyle(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: selectedStatus,
                                      items: statusOptions,
                                      hintText: 'Coming soon',
                                      errorText: _statusError,
                                      errorColor: errorColor,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStatus = value ;
                                          MovieCubit.get(context).selectedStatus = selectedStatus;
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
                                    Text("Movie Genre",
                                        style: TextStyle(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    SizedBox(height: 4.h),
                                    NewDropdownField(
                                      value: selectedGenre,
                                      items: genreOptions,
                                      hintText: 'Action, adventure, sci-fi',
                                      errorText: _movieGenreError,
                                      errorColor: errorColor,
                                      onChanged: (value) {
                                        setState(() {
                                           selectedGenre = value ;
                                          MovieCubit.get(context).selectedGenre = selectedGenre;
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
                    Expanded(child:  logo(
                      pickedCover: pickedCover,
                      onPick: (file) {
                        setState(() {
                          pickedCover = file;
                        });
                      },
                      onDelete: () {
                        setState(() {
                          pickedCover = null;
                        });
                      },
                      errorColor: Colors.red,
                      isViewOnly: false,
                    ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


