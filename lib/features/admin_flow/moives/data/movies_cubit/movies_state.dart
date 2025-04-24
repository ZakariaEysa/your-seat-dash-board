import 'package:yourseatgraduationproject/features/admin_flow/moives/data/models/movies_model.dart';


class MovieState {
  final MovieModel movie;
  final bool loading;
  final bool success;
  final String? error;

  MovieState({
    MovieModel? movie,
    this.loading = false,
    this.success = false,
    this.error,
  }) : movie = movie ?? MovieModel(
      name: '',
      duration: '',
      language: '',
      category: '',
      status: '',
      censorship: '',
      ageRating: '',
      description: '',
      releaseDate: '',
      rating: 0.0,
      trailer: '',
      posterImage: '',
      cast: [],
      castImages: [],
      crew: {}
  );

  MovieState copyWith({
    MovieModel? movie,
    bool? loading,
    bool? success,
    String? error,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
