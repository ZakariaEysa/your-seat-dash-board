import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDropdownWidget extends StatefulWidget {
  const MovieDropdownWidget({super.key});

  @override
  State<MovieDropdownWidget> createState() => MovieDropdownWidgetState();
}

class MovieDropdownWidgetState extends State<MovieDropdownWidget> {
  final List<String> movies = [
    'Avengers: Infinity War',
    'Guardians Of The Galaxy',
    'Shang chi: Legend of the Ten Rings',
  ];

  String? selectedMovie;
  String? lastSavedMovie; // <== دي اللي بنخزن فيها آخر اختيار
  bool movieError = false;

  bool validate() {
    setState(() {
      movieError = selectedMovie == null;
      if (!movieError) {
        lastSavedMovie = selectedMovie; // حفظ آخر اختيار بعد الفاليديشن
      }
    });
    return !movieError;
  }

  void resetToSaved() {
    setState(() {
      selectedMovie = lastSavedMovie; // رجع آخر قيمة مختارة
      movieError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      width: 55.w,
      height: 51.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: movieError ? Colors.red : Colors.black),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButton<String>(
        value: selectedMovie,
        hint: const Text('Movie name', style: TextStyle(color: Colors.black)),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        items: movies.map((String movie) {
          return DropdownMenuItem<String>(
            value: movie,
            child: Text(movie, style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedMovie = value;
            movieError = false;
          });
        },
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
