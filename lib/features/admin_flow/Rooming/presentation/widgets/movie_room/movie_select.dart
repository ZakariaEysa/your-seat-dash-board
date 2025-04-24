import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDropdownWidget extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const MovieDropdownWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

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
  String? lastSavedMovie;
  bool movieError = false;

  @override
  void initState() {
    super.initState();
    // تأكد من أن القيمة الابتدائية موجودة في الليست قبل تعيينها
    if (widget.initialValue != null && movies.contains(widget.initialValue)) {
      selectedMovie = widget.initialValue;
    } else {
      selectedMovie = null;
    }
  }

  bool validate() {
    setState(() {
      movieError = selectedMovie == null;
      if (!movieError) {
        lastSavedMovie = selectedMovie;
      }
    });
    return !movieError;
  }

  void resetToSaved() {
    setState(() {
      selectedMovie = lastSavedMovie;
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
          widget.onChanged(value);
        },
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
