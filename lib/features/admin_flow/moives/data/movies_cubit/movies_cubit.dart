// // cubits/movie/movie_cubit.dart
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/models/movies_model.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_state.dart';
//
//
// class MovieCubit extends Cubit<MovieState> {
//   final TextEditingController movieNameController = TextEditingController();
//   final TextEditingController durationController = TextEditingController();
//   final TextEditingController promoLinkController = TextEditingController();
//   TextEditingController storyLineController = TextEditingController();
//   PlatformFile? pickedCover;
//   List<TextEditingController>? directorControllers;
//   List<TextEditingController>? actorControllers;
//
//
//
//   String? selectedGenre;
//   String? selectedLanguage;
//   String? selectedCensorship;
//   String? selectedStatus;
//   MovieModel? movieModel;
//
//   MovieCubit() : super(MovieState());
//
//   static MovieCubit get(context) => BlocProvider.of<MovieCubit>(context);
//
//   void updateMovie(MovieModel updatedMovie) {
//     emit(state.copyWith(movie: updatedMovie));
//   }
//
//   Future<void> uploadMovieToFirestore() async {
//     try {
//       emit(state.copyWith(loading: true));
//       await FirebaseFirestore.instance
//           .collection('movies')
//           .add(state.movie.toMap());
//       emit(state.copyWith(success: true, loading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), loading: false));
//     }
//   }
//
//   printControllers(){
//     print(movieNameController.text);
//     print(durationController.text);
//     print(promoLinkController.text);
//     print(selectedGenre);
//     print(selectedLanguage);
//     print(selectedCensorship);
//     print(selectedStatus);
//     print(pickedCover);
//     print(storyLineController.text);
//     print(directorControllers.toString());
//     print(actorControllers!.toList());
//   }
// }
//

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_state.dart';
// import 'package:yourseatgraduationproject/utils/app_logs.dart';
//
// class MovieCubit extends Cubit<MovieState> {
//   final TextEditingController movieNameController = TextEditingController();
//   final TextEditingController durationController = TextEditingController();
//   final TextEditingController promoLinkController = TextEditingController();
//   final TextEditingController storyLineController = TextEditingController();
//   PlatformFile? pickedCover;
//   List<TextEditingController>? directorControllers;
//   List<TextEditingController>? actorControllers;
//
//   String? selectedGenre;
//   String? selectedLanguage;
//   String? selectedCensorship;
//   String? selectedStatus;
//
//   MovieCubit() : super(MovieState());
//
//   static MovieCubit get(context) => BlocProvider.of<MovieCubit>(context);
//
//   Future<String> uploadCoverToStorage(PlatformFile file) async {
//     try {
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('movie_covers/${DateTime.now().millisecondsSinceEpoch}_${file.name}');
//
//       UploadTask uploadTask = storageRef.putData(file.bytes!);
//       TaskSnapshot snapshot = await uploadTask;
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//   Future<void> uploadMovieToFirestore() async {
//     try {
//       emit(state.copyWith(loading: true));
//
//       String? coverUrl;
//       if (pickedCover != null) {
//         coverUrl = await uploadCoverToStorage(pickedCover!);
//       }
//
//       // crew: combine director, writer, producer
//       Map<String, String> crew = {};
//       if (directorControllers != null && directorControllers!.length >= 3) {
//         crew = {
//           'director': directorControllers![0].text,
//           'producer': directorControllers![1].text,
//           'writer': directorControllers![2].text,
//         };
//       }
//
//
//       // choose collection based on status
//      // String collectionName = selectedStatus == 'Playing now' ? 'Coming soon' : selectedStatus == 'Coming Soon' ? 'ComingSoon' : 'OtherMovies';
//
//
//       String collectionName = selectedStatus == 'Playing now' ? 'playing now films' : 'Movies';
//
//       Map<String, dynamic> movieData = {
//         'name': movieNameController.text,
//         'duration': durationController.text,
//         'trailer': promoLinkController.text,
//         'category': selectedGenre,
//         'language': selectedLanguage,
//         'age_rating': selectedCensorship,
//         'status': selectedStatus,
//         'poster_image': coverUrl,
//         'description': storyLineController.text,
//         'crew': crew,
//         'cast': actorControllers?.map((c) => c.text).toList() ?? [],
//       };
//
//       // // save to general Movies collection
//       // await FirebaseFirestore.instance
//       //     .collection('Movies')
//       //     .doc(movieNameController.text)
//       //     .set(movieData);
//
//       // save to status-based collection
//       await FirebaseFirestore.instance
//           .collection(collectionName)
//           .doc(movieNameController.text)
//           .set(movieData);
//
//       emit(state.copyWith(success: true, loading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), loading: false));
//     }
//   }
//
//   void printControllers() {
//     AppLogs.scussessLog("00000000000000000000000000");
//     print(movieNameController.text);
//     print(durationController.text);
//     print(promoLinkController.text);
//     print(selectedGenre);
//     print(selectedLanguage);
//     print(selectedCensorship);
//     print(selectedStatus);
//     print(pickedCover);
//     print(storyLineController.text);
//     print(directorControllers.toString());
//     print(actorControllers?.map((e) => e.text).toList());
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_state.dart';
// import 'package:yourseatgraduationproject/utils/app_logs.dart';
//
// class MovieCubit extends Cubit<MovieState> {
//   final TextEditingController movieNameController = TextEditingController();
//   final TextEditingController durationController = TextEditingController();
//   final TextEditingController promoLinkController = TextEditingController();
//   final TextEditingController storyLineController = TextEditingController();
//   PlatformFile? pickedCover;
//   List<TextEditingController>? directorControllers;
//   List<TextEditingController>? actorControllers;
//
//   String? selectedGenre;
//   String? selectedLanguage;
//   String? selectedCensorship;
//   String? selectedStatus;
//
//   MovieCubit() : super(MovieState());
//
//   static MovieCubit get(context) => BlocProvider.of<MovieCubit>(context);
//
//   Future<String> uploadCoverToStorage(PlatformFile file) async {
//     try {
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('movie_covers/${DateTime.now().millisecondsSinceEpoch}_${file.name}');
//
//       UploadTask uploadTask = storageRef.putData(file.bytes!);
//       TaskSnapshot snapshot = await uploadTask;
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//   Future<void> uploadMovieToFirestore() async {
//     try {
//       emit(state.copyWith(loading: true));
//
//       String? coverUrl;
//       if (pickedCover != null) {
//         coverUrl = await uploadCoverToStorage(pickedCover!);
//       }
//
//       // crew: combine director, writer, producer
//       Map<String, String> crew = {};
//       if (directorControllers != null && directorControllers!.length >= 3) {
//         crew = {
//           'director': directorControllers![0].text,
//           'producer': directorControllers![1].text,
//           'writer': directorControllers![2].text,
//         };
//       }
//
//       String collectionName = selectedStatus == 'Playing now' ? 'playing now films' : 'Movies';
//
//       Map<String, dynamic> movieData = {
//         'name': movieNameController.text,
//         'duration': durationController.text,
//         'trailer': promoLinkController.text,
//         'category': selectedGenre,
//         'language': selectedLanguage,
//         'age_rating': selectedCensorship,
//         'status': selectedStatus,
//         'poster_image': coverUrl,
//         'description': storyLineController.text,
//         'crew': crew,
//         'cast': actorControllers?.map((c) => c.text).toList() ?? [],
//       };
//
//       await FirebaseFirestore.instance
//           .collection(collectionName)
//           .doc(movieNameController.text)
//           .set(movieData);
//
//       emit(state.copyWith(success: true, loading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), loading: false));
//     }
//   }
//
//   void printControllers() {
//     AppLogs.scussessLog("00000000000000000000000000");
//     print(movieNameController.text);
//     print(durationController.text);
//     print(promoLinkController.text);
//     print(selectedGenre);
//     print(selectedLanguage);
//     print(selectedCensorship);
//     print(selectedStatus);
//     print(pickedCover);
//     print(storyLineController.text);
//     print(directorControllers.toString());
//     print(actorControllers?.map((e) => e.text).toList());
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_state.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/widgets/App_move.dart';
// import 'package:yourseatgraduationproject/utils/app_logs.dart';
// import 'dart:convert'; // لتحويل الصورة إلى Base64
//
// class MovieCubit extends Cubit<MovieState> {
//   final TextEditingController movieNameController = TextEditingController();
//   final TextEditingController durationController = TextEditingController();
//   final TextEditingController promoLinkController = TextEditingController();
//   final TextEditingController storyLineController = TextEditingController();
//   final TextEditingController directorController = TextEditingController();
//   final TextEditingController writerController = TextEditingController();
//   final TextEditingController producerController = TextEditingController();
//   final TextEditingController versionController = TextEditingController();
//
//   PlatformFile? pickedCover;
//   List<TextEditingController>? actorControllers;
//   List<PlatformFile?> pickedActorImages = [];
//
//   String? selectedGenre;
//   String? selectedLanguage;
//   String? selectedCensorship;
//   String? selectedStatus;
//
//   MovieCubit() : super(MovieState());
//
//   static MovieCubit get(context) => BlocProvider.of<MovieCubit>(context);
//
//   // دالة لتحويل الصورة إلى Base64
//   Future<String?> convertImageToBase64(PlatformFile file) async {
//     try {
//       // تحويل الصورة إلى بيانات بتنسيق Base64
//       final bytes = file.bytes;
//       if (bytes == null) return null;
//       return base64Encode(bytes);
//     } catch (e) {
//       throw Exception('Error converting image to Base64: $e');
//     }
//   }
//
//   // دالة رفع الفيلم إلى Firestore
//   Future<void> uploadMovieToFirestore() async {
//     try {
//       emit(state.copyWith(loading: true));
//
//       String? coverBase64;
//       if (pickedCover != null) {
//         // تحويل الصورة إلى Base64
//         coverBase64 = await convertImageToBase64(pickedCover!);
//       }
//
//       // دمج معلومات الطاقم (مخرج، منتج، كاتب)
//       Map<String, String> crew = {};
//
//         crew = {
//           'director': directorController.text,
//           'producer': producerController.text,
//           'writer': writerController.text,
//
//       };
//
//       // تحديد اسم المجموعة بناءً على الحالة
//       String collectionName =
//           selectedStatus == 'Playing now' ? 'playing now films' : 'Movies';
//
//       // بناء بيانات الفيلم
//       Map<String, dynamic> movieData = {
//         'name': movieNameController.text,
//         'duration': durationController.text,
//         'trailer': promoLinkController.text,
//         'category': selectedGenre,
//         'language': selectedLanguage,
//         'age_rating': selectedCensorship,
//         'status': selectedStatus,
//         'poster_image': coverBase64, // تخزين الصورة بصيغة Base64
//         'description': storyLineController.text,
//         'crew': crew,
//         'rating': 0,
//         'cast': actorControllers?.map((c) => c.text).toList() ?? [],
//       };
//
//       // تخزين البيانات في المجموعة المناسبة بناءً على الحالة
//       await FirebaseFirestore.instance
//           .collection(collectionName)
//           .doc(movieNameController.text)
//           .set(movieData);
//
//       emit(state.copyWith(success: true, loading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), loading: false));
//     }
//   }
//
//   // طباعة قيم المتغيرات (لأغراض التصحيح)
//   void printControllers() {
//     AppLogs.scussessLog("00000000000000000000000000");
//     print(movieNameController.text);
//     print(durationController.text);
//     print(promoLinkController.text);
//     print(selectedGenre);
//     print(selectedLanguage);
//     print(selectedCensorship);
//     print(selectedStatus);
//     AppLogs.scussessLog("000000000000");
//     print(producerController);
//     print(directorController);
//     print(writerController);
//     AppLogs.scussessLog("000000000000");
//    // print(pickedCover);
//     print(actorControllers);
//     print(storyLineController.text);
//     print(versionController);
//   }
// }


import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_state.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

class MovieCubit extends Cubit<MovieState> {
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController promoLinkController = TextEditingController();
  final TextEditingController storyLineController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController writerController = TextEditingController();
  final TextEditingController producerController = TextEditingController();
  final TextEditingController versionController = TextEditingController();

  PlatformFile? pickedCover;
  List<TextEditingController>? actorControllers;
  List<PlatformFile?> pickedActorImages = [];
  List<PlatformFile?> pickedDirectorImages = [];
  List<PlatformFile?> pickedWriterImages = [];
  List<PlatformFile?> pickedProducerImages = [];

  String? selectedGenre;
  String? selectedLanguage;
  String? selectedCensorship;
  String? selectedStatus;

  MovieCubit() : super(MovieState());

  static MovieCubit get(context) => BlocProvider.of<MovieCubit>(context);

  Future<String?> convertImageToBase64(PlatformFile file) async {
    try {
      final bytes = file.bytes;
      if (bytes == null) return null;
      return base64Encode(bytes);
    } catch (e) {
      throw Exception('Error converting image to Base64: $e');
    }
  }

  Future<void> uploadMovieToFirestore() async {
    try {
      emit(state.copyWith(loading: true));

      String? coverBase64;
      if (pickedCover != null) {
        coverBase64 = await convertImageToBase64(pickedCover!);
      }

      Map<String, String> crew = {
        'director': directorController.text,
        'producer': producerController.text,
        'writer': writerController.text,
      };

      List<String> actorImagesBase64 = [];
      List<String> crewImagesBase64 = [];
      for (final imageFile in pickedActorImages) {
        if (imageFile != null) {
          final base64 = await convertImageToBase64(imageFile);
          if (base64 != null) actorImagesBase64.add(base64);
        }
      }

      List<String> directorImagesBase64 = [];
      for (final imageFile in pickedDirectorImages) {
        if (imageFile != null) {
          final base64 = await convertImageToBase64(imageFile);
          if (base64 != null) crewImagesBase64.add(base64);
        }
      }

      List<String> writerImagesBase64 = [];
      for (final imageFile in pickedWriterImages) {
        if (imageFile != null) {
          final base64 = await convertImageToBase64(imageFile);
          if (base64 != null) crewImagesBase64.add(base64);
        }
      }

      List<String> producerImagesBase64 = [];
      for (final imageFile in pickedProducerImages) {
        if (imageFile != null) {
          final base64 = await convertImageToBase64(imageFile);
          if (base64 != null) crewImagesBase64.add(base64);
        }
      }

      String collectionName =
      selectedStatus == 'Playing now' ? 'playing now films' : 'Movies';

      Map<String, dynamic> movieData = {
        'name': movieNameController.text,
        'duration': durationController.text,
        'trailer': promoLinkController.text,
        'category': selectedGenre,
        'language': selectedLanguage,
        'age_rating': selectedCensorship,
        'status': selectedStatus,
        'poster_image': coverBase64,
        'description': storyLineController.text,
        'crew': crew,
        'crew_images': {
          'director': crewImagesBase64[0],
          'writer':  crewImagesBase64[1],
          'producer':  crewImagesBase64[2],
        },
        'rating': 0,
        'cast': actorControllers?.map((c) => c.text).toList() ?? [],
        'cast_images': actorImagesBase64,
      };

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(movieNameController.text)
          .set(movieData);

      emit(state.copyWith(success: true, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  void printControllers() {
    AppLogs.scussessLog("00000000000000000000000000");
    //print(actorControllers?.map((e) => e.text).toList());
    //print(pickedActorImages);
    print(pickedDirectorImages);
    print(pickedProducerImages);
    print(pickedWriterImages);
  }
}



