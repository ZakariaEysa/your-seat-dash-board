import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../movie_detail/presentation/view/movie_details.dart';
import '../../movie_detail/presentation/widgets/movie_info.dart'; // تأكد من أن المسار صحيح

class MovieTablePage extends StatefulWidget {
  @override
  _MovieTablePageState createState() => _MovieTablePageState();
}

class _MovieTablePageState extends State<MovieTablePage> {
  final List<Map<String, String>> movies = [
    {"name": "Natali Craig", "date": "3h 19m", "time": "Drama", "rooms": "Turkish", "status": "Coming soon", "image": "assets/images/NataliCraig.png"},
    {"name": "Kate Morrison", "date": "2h 10", "time": "Comedy", "rooms": "Chinese", "status": "Playing now", "image": "assets/images/KateMorrison.png"},
    {"name": "Drew Cano", "date": "1h 30", "time": "Action", "rooms": "Korean", "status": "Playing now", "image": "assets/images/DrewCano.png"},
    {"name": "Orlando Diggs", "date": "2h 15h", "time": "Musical", "rooms": "Japanese", "status": "Playing now", "image": "assets/images/OrlandoDiggs.png"},
    {"name": "Andi Lane", "date": "3h", "time": "Biography", "rooms": "Hindi", "status": "Not show", "image": "assets/images/AndiLane.png"},

    {"name": "Natali Craig", "date": "2h 30m", "time": "Mystery", "rooms": "German", "status": "Playing now", "image": "assets/images/NataliCraig.png"},
    {"name": "Kate Morrison", "date": "1h 47m", "time": "Crime", "rooms": "German", "status": "Coming soon", "image": "assets/images/KateMorrison.png"},
    {"name": "Drew Cano", "date": "2h", "time": "Documentary", "rooms": "Spanish", "status": "Coming soon", "image": "assets/images/DrewCano.png"},
    {"name": "Orlando Diggs", "date": "2h 30m", "time": "Documentary", "rooms": "French", "status": "Playing now", "image": "assets/images/OrlandoDiggs.png"},
    {"name": "Andi Lane", "date": "1h 50m", "time": "Animation", "rooms": "Arabic", "status": "Not show", "image": "assets/images/AndiLane.png"}
  ];

  int? _selectedRowIndex;

  void navigateToMovieDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetail()),
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
      case 'Not show':
        return Colors.grey;
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
                columnSpacing: 100,
                headingRowColor: MaterialStateProperty.all(Colors.white),
                dividerThickness: 1.0,
                dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.grey[300];
                  }
                  return Colors.white;
                }),
                columns: const [
                  DataColumn(label: Text('Movie name', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Duration', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Movie Genre', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Language', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Status', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Action', style: TextStyle(color: Colors.grey)))
                ],//Censorship
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
                        DataCell(Row(
                            children: [
                              CircleAvatar(backgroundImage: AssetImage(movie['image']!)),
                              SizedBox(width: 4.w),
                              Text(movie['name']!, style: TextStyle(color: Colors.black))
                            ]
                        )),
                        DataCell(Text(movie['date']!, style: TextStyle(color: Colors.black))),
                        DataCell(Text(movie['time']!, style: TextStyle(color: Colors.black))),
                        DataCell(Text(movie['rooms']!, style: TextStyle(color: Colors.black))),
                        DataCell(Row(
                            children: [
                              Container(
                                  width: 7.w,
                                  height: 7.h,
                                  decoration: BoxDecoration(
                                      color: getStatusColor(movie['status']!),
                                      shape: BoxShape.circle
                                  )
                              ),
                              SizedBox(width: 4.w),
                              Text(movie['status']!, style: TextStyle(color: getStatusColor(movie['status']!)))
                            ]
                        )),
                        DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_red_eye, color: Colors.purple),
                                onPressed: isSelected
                                    ? () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("View Movie"),
                                    content: Text("Do you want to view movie details?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            navigateToMovieDetail(context);
                                          },
                                          child: Text("OK")),
                                    ],
                                  ),
                                )
                                    : null,
                              ),

                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: isSelected
                                    ? () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Edit Movie"),
                                    content: Text("Do you want to edit this movie?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            navigateToMovieDetail(context);
                                          },
                                          child: Text("OK")),
                                    ],
                                  ),
                                )
                                    : null,
                              ),

                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: isSelected
                                    ? () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Delete Movie"),
                                    content: Text("Are you sure you want to delete this movie?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            deleteMovie(index);
                                          },
                                          child: Text("OK")),
                                    ],
                                  ),
                                )
                                    : null,
                              ),

                            ]
                        ))
                      ]
                  );
                }).toList()
            )
        )
    );
  }
}