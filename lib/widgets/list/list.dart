import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/admin_flow/Rooming/presentation/views/rooming.dart';
import '../../features/admin_flow/Ticket_details/presentation/views/ticket_details.dart';
import '../../features/admin_flow/halls/view/halls.dart';
import '../../features/admin_flow/halls2/view/halls2.dart';
import '../../features/admin_flow/homepage/view/home.dart';
import '../../features/admin_flow/moives/view/movies.dart';
import '../../features/admin_flow/setting/presentation/widgets/App_move.dart';
import '../../features/admin_flow/transactions/view/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/admin_flow/Rooming/presentation/views/rooming.dart';
import '../../features/admin_flow/Ticket_details/presentation/views/ticket_details.dart';
import '../../features/admin_flow/halls/view/halls.dart';
import '../../features/admin_flow/homepage/view/home.dart';
import '../../features/admin_flow/moives/view/movies.dart';
import '../../features/admin_flow/setting/presentation/widgets/App_move.dart';
import '../../features/admin_flow/transactions/view/transactions.dart';


class NavigationList extends StatefulWidget {
  @override
  State<NavigationList> createState() => _NavigationListState();
}

class _NavigationListState extends State<NavigationList> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // const Center(child: Text("Home Page", style: TextStyle(fontSize: 24))),
   Home(),
    Transactions(),
    Halls2(),
    Movies(),
    TicketDetails(),
    Rooming(),
    App(),
    const Center(child: Text("Logging Out...", style: TextStyle(fontSize: 24))),
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
            color: const Color(0xFF5A2D82),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/yourseat.png", width: 80.w),
                SizedBox(height: 15.h),
                // ✅ بناء عناصر القائمة
                for (int i = 0; i < _menuItems.length; i++) buildNavItem(i),
              ],
            ),
          ),

          // ✅ منطقة عرض الصفحة
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }

  /// ✅ **بناء عنصر القائمة (الأيقونة والنص) مع المسافات**
  Widget buildNavItem(int index) {
    bool isSelected = index == _currentIndex;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
              margin: EdgeInsets.only(left: 5.w),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purple[300] : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    _menuItems[index]['icon'],
                    color: Colors.white,
                    size: 6.sp,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _menuItems[index]['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 3.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                left: 5.w,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1.w,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
