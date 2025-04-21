import 'package:flutter/material.dart';

import '../../../../../widgets/validators/Validators.dart';

class MovieInfoController {
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController promoLinkController = TextEditingController();

  String? selectedGenre;
  String? selectedLanguage;
  String? selectedCensorship;
  String? selectedStatus;

  String? movieNameError;
  String? durationError;
  String? movieGenreError;
  String? languageError;
  String? censorshipError;
  String? statusError;
  String? promoLinkError;

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

  void initialize(Map<String, dynamic> movieData) {
    movieNameController.text = movieData['name'] ?? '';
    durationController.text = movieData['date'] ?? '';
    promoLinkController.text = movieData['promoUrl'] ?? '';

    selectedGenre = genreOptions.contains(movieData['genre']) ? movieData['genre'] : null;
    selectedLanguage = languageOptions.contains(movieData['rooms']) ? movieData['rooms'] : null;
    selectedStatus = statusOptions.contains(movieData['status']) ? movieData['status'] : null;
    selectedCensorship = censorshipOptions.contains(movieData['censorship']) ? movieData['censorship'] : null;
  }

  bool validateFields() {
    movieNameError = Validators.validateRequired(
        movieNameController.text, 'Movie name',
        lettersOnly: true, allowSpaces: true);
    durationError = Validators.validateDurationFormat(durationController.text);
    movieGenreError = Validators.validateRequired(selectedGenre, 'Movie genre');
    languageError = Validators.validateRequired(selectedLanguage, 'Language');
    censorshipError = Validators.validateRequired(selectedCensorship, 'Censorship');
    statusError = Validators.validateRequired(selectedStatus, 'Status');
    promoLinkError = Validators.validateYouTubeLink(promoLinkController.text);

    return movieNameError == null &&
        durationError == null &&
        movieGenreError == null &&
        languageError == null &&
        censorshipError == null &&
        statusError == null &&
        promoLinkError == null;
  }

  void dispose() {
    movieNameController.dispose();
    durationController.dispose();
    promoLinkController.dispose();
  }
}