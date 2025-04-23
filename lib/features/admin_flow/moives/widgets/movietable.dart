import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../movie_detail/presentation/view/movie_details.dart'; // تأكد من أن المسار صحيح

class MovieTablePage extends StatefulWidget {
  @override
  _MovieTablePageState createState() => _MovieTablePageState();
}

class _MovieTablePageState extends State<MovieTablePage> {
  final List<Map<String, String>> movies = [
    {"name": "Natali Craig", "date": "20-2-2025", "time": "6:55PM", "rooms": "Room 1, Room 2", "status": "Coming soon", "image": "assets/images/NataliCraig.png"},
    {"name": "Kate Morrison", "date": "20-2-2025", "time": "7:40PM", "rooms": "Room 7", "status": "Playing now", "image": "assets/images/KateMorrison.png"},
    {"name": "Drew Cano", "date": "20-2-2025", "time": "8:55PM", "rooms": "Room 1", "status": "Playing now", "image": "assets/images/DrewCano.png"},
    {"name": "Orlando Diggs", "date": "21-5-2024", "time": "4:50PM", "rooms": "Room 2", "status": "Playing now", "image": "assets/images/OrlandoDiggs.png"},
    {"name": "Andi Lane", "date": "6-9-2023", "time": "2:55PM", "rooms": "Room 8", "status": "Not show", "image": "assets/images/AndiLane.png"},

    {"name": "Natali Craig", "date": "15-6-2024", "time": "6:55PM", "rooms": "room 2", "status": "Playing now", "image": "assets/images/NataliCraig.png"},
    {"name": "Kate Morrison", "date": "6-9-2023", "time": "7:40PM", "rooms": "Room 4", "status": "Coming soon", "image": "assets/images/KateMorrison.png"},
    {"name": "Drew Cano", "date": "8-6-2023", "time": "8:55PM", "rooms": "Room 3", "status": "Coming soon", "image": "assets/images/DrewCano.png"},
    {"name": "Orlando Diggs", "date": "25-9-2023", "time": "4:50PM", "rooms": "Room 4", "status": "Playing now", "image": "assets/images/OrlandoDiggs.png"},
    {"name": "Andi Lane", "date": "26-8-2024", "time": "2:55PM", "rooms": "Room 2", "status": "Not show", "image": "assets/images/AndiLane.png"}
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
                  DataColumn(label: Text('Date', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Time', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Rooms', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Status', style: TextStyle(color: Colors.grey))),
                  DataColumn(label: Text('Action', style: TextStyle(color: Colors.grey)))
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
                                  icon: const Icon(Icons.edit, color: Colors.green),
                                  onPressed: isSelected ? () => navigateToMovieDetail(context) : null
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: isSelected ? () => deleteMovie(index) : null
                              )
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

