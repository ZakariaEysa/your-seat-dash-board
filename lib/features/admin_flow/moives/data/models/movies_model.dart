// models/movie_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieModel {
  final String name;
  final String duration;
  final String language;
  final String category;
  final String status;
  final String censorship;
  final String ageRating;
  final String description;
  final String releaseDate;
  final double rating;
  final String trailer;
  final String posterImage;
  final List<String> cast;
  final List<String> castImages;
  final Map<String, String> crew;

  MovieModel({
    required this.name,
    required this.duration,
    required this.language,
    required this.category,
    required this.status,
    required this.censorship,
    required this.ageRating,
    required this.description,
    required this.releaseDate,
    required this.rating,
    required this.trailer,
    required this.posterImage,
    required this.cast,
    required this.castImages,
    required this.crew,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'language': language,
      'category': category,
      'status': status,
      'censorship': censorship,
      'age_rating': ageRating,
      'description': description,
      'release_date': releaseDate,
      'rating': rating,
      'trailer': trailer,
      'poster_image': posterImage,
      'cast': cast,
      'cast_images': castImages,
      'crew': crew,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  MovieModel copyWith({
    String? name,
    String? duration,
    String? language,
    String? category,
    String? status,
    String? censorship,
    String? ageRating,
    String? description,
    String? releaseDate,
    double? rating,
    String? trailer,
    String? posterImage,
    List<String>? cast,
    List<String>? castImages,
    Map<String, String>? crew,
  }) {
    return MovieModel(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      language: language ?? this.language,
      category: category ?? this.category,
      status: status ?? this.status,
      censorship: censorship ?? this.censorship,
      ageRating: ageRating ?? this.ageRating,
      description: description ?? this.description,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      trailer: trailer ?? this.trailer,
      posterImage: posterImage ?? this.posterImage,
      cast: cast ?? this.cast,
      castImages: castImages ?? this.castImages,
      crew: crew ?? this.crew,
    );
  }
}
