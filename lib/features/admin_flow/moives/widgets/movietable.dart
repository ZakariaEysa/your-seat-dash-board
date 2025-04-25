import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../movie_detail/presentation/view/movie_details.dart';

class MovieTablePage extends StatefulWidget {
  @override
  _MovieTablePageState createState() => _MovieTablePageState();
}

class _MovieTablePageState extends State<MovieTablePage> {
  final List<Map<String, String>> movies = [
    {
      "name": "Natali Craig",
      "duration": "119m",
      "genre": "Drama",
      "language": "Turkish",
      "status": "Coming soon",
      "image": "assets/images/NataliCraig.png",
      "censorship": "R",
      "storyLine": "A dramatic story about love and choices.",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/natali_craig_trailer",
      "vresionnumber": "2024-09-10",
      "Producer Name": "Ava Bennett",
      "Writer Name": "Lucas Scott",
      "Director Name": "Caleb Turner"
    },
    {
      "name": "Kate Morrison",
      "duration": "110m",
      "genre": "Comedy",
      "language": "Chinese",
      "status": "Playing now",
      "image": "assets/images/KateMorrison.png",
      "censorship": "PG-13",
      "storyLine":
      "As the Avengers and their allies have continued to protect the world...",
      "directors": "Paul Walker",
      "actors": "Emma Stone, Jack White",
      "promoUrl": "https://youtu.be/kate_morrison_trailer",
      "vresionnumber": "2024-10-15",
      "Producer Name": "Liam Carter",
      "Writer Name": "Olivia Harper",
      "Director Name": "Ethan Cole"
    },
    {
      "name": "Drew Cano",
      "duration": "130m",
      "genre": "Action",
      "language": "Korean",
      "status": "Playing now",
      "image": "assets/images/DrewCano.png",
      "censorship": "tv-14",
      "storyLine":
      "As the Avengers and their allies have continued to protect the world...",
      "directors": "Anthony Russo",
      "actors": "Joe Russo, Christopher Robert",
      "promoUrl": "https://youtu.be/drew_cano_trailer",
      "vresionnumber": "2024-11-01",
      "Producer Name": "Mason Hayes",
      "Writer Name": "Sophia Bell",
      "Director Name": "Noah Adams"
    },
    {
      "name": "Orlando Diggs",
      "duration": "115m",
      "genre": "Musical",
      "language": "Japanese",
      "status": "Playing now",
      "image": "assets/images/OrlandoDiggs.png",
      "censorship": "TV-PG",
      "storyLine": "A dramatic story about love and choices.",
      "directors": "John Doe, Christopher Robert",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/orlando_diggs_trailer",
      "vresionnumber": "2024-09-25",
      "Producer Name": "Ava Bennett",
      "Writer Name": "Lucas Scott",
      "Director Name": "Caleb Turner"
    },
    {
      "name": "Andi Lane",
      "duration": "138m",
      "genre": "Biography",
      "language": "Hindi",
      "status": "Coming soon",
      "image": "assets/images/AndiLane.png",
      "censorship": "NC-17",
      "storyLine": "A dramatic story about love and choices.",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/andi_lane_trailer",
      "vresionnumber": "2024-12-01",
      "Producer Name": "Ella Morgan",
      "Writer Name": "Henry Clark",
      "Director Name": "Zachary Brooks"
    }, {
      "name": "Natali Craig",
      "duration": "130m",
      "genre": "Mystery",
      "language": "German",
      "status": "Playing now",
      "image": "assets/images/NataliCraig.png",
      "censorship": "PG",
      "storyLine":
      "As the Avengers and their allies have continued to protect the world...",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/natali_craig_trailer_2",
      "vresionnumber": "2024-10-20",
      "Producer Name": "Isabella Reed",
      "Writer Name": "Owen Mitchell",
      "Director Name": "Sebastian Ford"
    },
    {
      "name": "Kate Morrison",
      "duration": "147m",
      "genre": "Crime",
      "language": "German",
      "status": "Coming soon",
      "image": "assets/images/KateMorrison.png",
      "censorship": "TV-Y7",
      "storyLine": "A dramatic story about love and choices.",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/kate_morrison_trailer_2",
      "vresionnumber": "2024-11-20",
      "Producer Name": "Daniel Woods",
      "Writer Name": "Chloe Simmons",
      "Director Name": "Nathan Hayes"
    },
    {
      "name": "Drew Cano",
      "duration": "222m",
      "genre": "Documentary",
      "language": "Spanish",
      "status": "Coming soon",
      "image": "assets/images/DrewCano.png",
      "censorship": "TV-G",
      "storyLine":
      "As the Avengers and their allies have continued to protect the world...",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/drew_cano_trailer_2",
      "vresionnumber": "2024-12-10",
      "Producer Name": "Emily Gray",
      "Writer Name": "Aiden Kelly",
      "Director Name": "Julian Ross"
    },
    {
      "name": "Orlando Diggs",
      "duration": "160m",
      "genre": "Documentary",
      "language": "French",
      "status": "Playing now",
      "image": "assets/images/OrlandoDiggs.png",
      "censorship": "G",
      "storyLine": "A dramatic story about love and choices.",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/orlando_diggs_trailer_2",
      "vresionnumber": "2024-10-30",
      "Producer Name": "Grace Martin",
      "Writer Name": "Connor Lee",
      "Director Name": "Miles Bennett"
    },
    {
      "name": "Andi Lane",
      "duration": "150m",
      "genre": "Animation",
      "language": "Arabic",
      "status": "Coming soon",
      "image": "assets/images/AndiLane.png",
      "censorship": "tv-14",
      "storyLine":
      "As the Avengers and their allies have continued to protect the world...",
      "directors": "John Doe",
      "actors": "Jane Smith, Alex Brown",
      "promoUrl": "https://youtu.be/andi_lane_trailer_2",
      "vresionnumber": "2024-11-28",
      "Producer Name": "Lily Foster",
      "Writer Name": "Benjamin Ross",
      "Director Name": "Ryan Carter"
    }  ];

  int? _selectedRowIndex;

  void navigateToMovieDetail(
      BuildContext context,
      Map<String, String> movie, {
        bool isViewOnly = false,
        bool isEditing = false,
      }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetail(
          movieData: movie,
          isViewOnly: isViewOnly,
          isEditing: isEditing,
        ),
      ),
    );
  }

  void deleteMovie(int index) {
    setState(() {
      movies.removeAt(index);
      _selectedRowIndex = null;
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Coming soon':
        return Color(0xFF8A8CD9);
      case 'Playing now':
        return Color(0xFF4AA785);
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
        showCheckboxColumn: false,
        columnSpacing: 70,
        headingRowColor: MaterialStateProperty.all(Colors.white),
    dividerThickness: 1.0,
    dataRowColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
    return Colors.grey[300];
    }
    return Colors.white;
    },
    ),
    columns: const [
        DataColumn(
        label: Text('Movie name', style: TextStyle(color: Colors.grey)),
        ),
        DataColumn(
          label: Text('Duration', style: TextStyle(color: Colors.grey)),
        ),
        DataColumn(
          label: Text('Movie Genre', style: TextStyle(color: Colors.grey)),
        ),
        DataColumn(
          label: Text('Language', style: TextStyle(color: Colors.grey)),
        ),
        DataColumn(
          label: Text('Status', style: TextStyle(color: Colors.grey)),
        ),
        DataColumn(
          label: Text('Censorship', style: TextStyle(color: Colors.grey)),
        ),
        DataColumn(
          label: Text('Action', style: TextStyle(color: Colors.grey)),
        ),
        ],
    rows: movies.map((movie) {
    final int index = movies.indexOf(movie);
    final bool isSelected = _selectedRowIndex == index;
    return DataRow(
    selected: isSelected,
    onSelectChanged: (selected) {
    setState(() {
    _selectedRowIndex = isSelected ? null : index;
    });
    },
    cells: [
    DataCell(Row(children: [
    CircleAvatar(backgroundImage: AssetImage(movie['image']!)),
    SizedBox(width: 4.w),
    Text(movie['name']!, style: TextStyle(color: Colors.black))
    ])),
    DataCell(Text(movie['duration']!,
    style: TextStyle(color: Colors.black))),
    DataCell(Text(movie['genre']!,
    style: TextStyle(color: Colors.black))),
    DataCell(Text(movie['language']!,
    style: TextStyle(color: Colors.black))),
    DataCell(Row(children: [
    Container(
    width: 7.w,
    height: 7.h,
    decoration: BoxDecoration(
    color: getStatusColor(movie['status']!),
    shape: BoxShape.circle),
    ),
    SizedBox(width: 4.w),
    Text(movie['status']!,
    style: TextStyle(color: getStatusColor(movie['status']!)))
    ])),
    DataCell(Text(movie['censorship']!,
    style: TextStyle(color: Colors.black))),
    DataCell(Row(
    children: [
    IconButton(
    icon: Icon(Icons.remove_red_eye, color: Colors.purple),
    onPressed: isSelected
    ? () => showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text("View Movie"),
    content: Text(
    "Do you want to view this movie details?"),
    actions: [
    TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text("Cancel"),
    ),
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    navigateToMovieDetail(
    context,
    movie,
    isViewOnly: true,
    );
    },
    child: Text("View"),
    ),
    ],
    ),
    )
        : null,
    tooltip: 'View Only (No Editing)',
    ),
    IconButton(
    icon: Icon(Icons.edit, color: Colors.green),
    onPressed: isSelected
    ? () => showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text("Edit Movie"),
    content: Text(
    "Do you want to edit this movie?"),
    actions: [
    TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text("Cancel"),
    ),
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    navigateToMovieDetail(
    context,
    movie,
    isViewOnly: false,
    isEditing: true,
    );
    },
    child: Text("Edit"),
    ),
    ],
    ),
    )
        : null,
    tooltip: 'Edit Movie Details',
    ),
    IconButton(
    icon: Icon(Icons.delete, color: Colors.red),
    onPressed: isSelected
    ? () => showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text("Delete Movie"),
    content: Text(
    "Are you sure you want to delete this movie?"),
    actions: [
    TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text("Cancel"),
    ),
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    deleteMovie(index);
    },
    child: Text("OK"),
    ),
    ],
    ),
    )
        : null,
    tooltip: 'Delete Movie Details',
    ),
    ],
    )),
    ],
    );
    }).toList(),
    ),
    ),
    );
  }
}