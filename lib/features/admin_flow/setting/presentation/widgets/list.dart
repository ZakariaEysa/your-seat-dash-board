import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/Rooming/presentation/views/rooming.dart';
import 'package:yourseatgraduationproject/features/admin_flow/Ticket_details/presentation/views/ticket_details.dart';
import 'package:yourseatgraduationproject/features/admin_flow/setting/presentation/widgets/App_move.dart';

class NavigationList extends StatefulWidget {
  @override
  State<NavigationList> createState() => _NavigationListState();
}

class _NavigationListState extends State<NavigationList> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("Home Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Transactions", style: TextStyle(fontSize: 24))),
    Center(child: Text("Halls", style: TextStyle(fontSize: 24))),
    Center(child: Text("Movies", style: TextStyle(fontSize: 24))),
    TicketDetails(),
    Rooming(),
    App(),
    Center(child: Text("Logging Out...", style: TextStyle(fontSize: 24))),
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.grid_view, 'title': 'Home'},
    {'icon': Icons.receipt, 'title': 'Transactions'},
    {'icon': Icons.apartment, 'title': 'Halls'},
    {'icon': Icons.movie, 'title': 'Movies'},
    {'icon': Icons.confirmation_number, 'title': 'Ticket details'},
    {'icon': Icons.meeting_room, 'title': 'Rooming'},
    {'icon': Icons.settings, 'title': 'Setting'},
    {'icon': Icons.logout, 'title': 'LogOut'},
  ];

  @override
  Widget build(BuildContext context) {

    double sideBarWidth = 45.w;

    return Scaffold(
      body: Row(
        children: [

          Container(
            width: sideBarWidth,
            color: Color(0xFF5A2D82),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/yourseat.png"),
                SizedBox(height:15.h),

                for (int i = 0; i < _menuItems.length; i++)
                  buildNavItem(i),
              ],
            ),
          ),

          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(int index) {
    bool isSelected = index == _currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical:2.w, horizontal:1.h),
            color: isSelected ? Colors.purple[200] : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  _menuItems[index]['icon'],
                  color: Colors.white,
                  size:8.sp,
                ),
                 SizedBox(width:3.w),
                Text(
                  _menuItems[index]['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:3.sp,
                  ),
                ),
              ],
            ),
          ),

          if (isSelected)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 1.w,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }


}
