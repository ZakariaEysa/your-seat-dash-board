import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../widgets/validators/Validators.dart';
import 'NewDropdownField.dart';
import 'movie_image.dart';
import 'movie_text_field_label.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({Key? key}) : super(key: key);

  @override
  MovieInfoScreenState createState() => MovieInfoScreenState();
}

class MovieInfoScreenState extends State<MovieInfoScreen> {
  // Define consistent error color
  static const Color errorColor = Color(0xFFE53935); // Consistent red color

  final TextEditingController _movieNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _promoLinkController = TextEditingController();

  String? selectedGenre;
  String? selectedLanguage;
  String? selectedCensorship;
  String? selectedStatus;

  String? _movieNameError;
  String? _durationError;
  String? _movieGenreError;
  String? _languageError;
  String? _censorshipError;
  String? _statusError;
  String? _promoLinkError;

  PlatformFile? pickedCover;

  // Options lists
  final List<String> genreOptions = [
    'Action', 'Comedy', 'Drama', 'Horror', 'Adventure', 'Romance',
    'Sci-Fi', 'Fantasy', 'Thriller', 'Animation', 'Documentary',
    'Crime', 'Mystery', 'Biography', 'Musical'
  ];

  final List<String> languageOptions = [
    'English', 'Arabic', 'French', 'Spanish', 'German',
    'Hindi', 'Japanese', 'Korean', 'Chinese', 'Turkish'
  ];

  final List<String> censorshipOptions = [
    'tv-ma', 'tv-14', 'R', 'TV-PG', 'PG-13', 'PG',
    'TV-Y7', 'TV-G', 'G', 'NC-17',
  ];

  final List<String> statusOptions = [
    'Playing now', 'Coming soon', 'Not show',
    'Not approved', 'Postponed', 'Cancelled',
  ];

  void handlePick(PlatformFile? file) {
    setState(() => pickedCover = file);
  }

  void handleDelete() {
    setState(() => pickedCover = null);
  }

  bool validateFields() {
    setState(() {
      _movieNameError = Validators.validateRequired(
        _movieNameController.text,
        'Movie name',
        lettersOnly: true,
        allowSpaces: true,
      );
      _durationError = Validators.validateRequired(
          _durationController.text,
          'Duration'
      );
      _movieGenreError = Validators.validateRequired(
          selectedGenre,
          'Movie genre'
      );
      _languageError = Validators.validateRequired(
          selectedLanguage,
          'Language'
      );
      _censorshipError = Validators.validateRequired(
          selectedCensorship,
          'Censorship'
      );
      _statusError = Validators.validateRequired(
          selectedStatus,
          'Status'
      );
      _promoLinkError = Validators.validateYouTubeLink(
          _promoLinkController.text
      );
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
    _movieNameController.dispose();
    _durationController.dispose();
    _promoLinkController.dispose();
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Form fields
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
                              controller: _movieNameController,
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
                              controller: _durationController,
                              errorText: _durationError,
                              errorColor: errorColor,
                              onChanged: (value) {
                                setState(() {
                                  _durationError = Validators.validateRequired(
                                      value,
                                      'Duration'
                                  );
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
                                Text(
                                  "Language",
                                  style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                NewDropdownField(
                                  value: selectedLanguage,
                                  items: languageOptions,
                                  hintText: 'English',
                                  errorText: _languageError,
                                  errorColor: errorColor,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLanguage = value;
                                      _languageError = Validators.validateRequired(
                                          value,
                                          'Language'
                                      );
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
                                Text(
                                  "Censorship",
                                  style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                NewDropdownField(
                                  value: selectedCensorship,
                                  items: censorshipOptions,
                                  hintText: 'TV-Y7',
                                  errorText: _censorshipError,
                                  errorColor: errorColor,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCensorship = value;
                                      _censorshipError = Validators.validateRequired(
                                          value,
                                          'Censorship'
                                      );
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
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                NewDropdownField(
                                  value: selectedStatus,
                                  items: statusOptions,
                                  hintText: 'Coming soon',
                                  errorText: _statusError,
                                  errorColor: errorColor,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatus = value;
                                      _statusError = Validators.validateRequired(
                                          value,
                                          'Status'
                                      );
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
                                Text(
                                  "Movie Genre",
                                  style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                NewDropdownField(
                                  value: selectedGenre,
                                  items: genreOptions,
                                  hintText: 'Action, adventure, sci-fi',
                                  errorText: _movieGenreError,
                                  errorColor: errorColor,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGenre = value;
                                      _movieGenreError = Validators.validateRequired(
                                          value,
                                          'Movie genre'
                                      );
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
                  child: MovieImageSection(
                    pickedCover: pickedCover,
                    onPick: handlePick,
                    onDelete: handleDelete,
                    promoLinkController: _promoLinkController,
                    promoLinkError: _promoLinkError,
                    errorColor: errorColor,
                    onLinkChanged: (value) {
                      setState(() {
                        _promoLinkError = Validators.validateYouTubeLink(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}