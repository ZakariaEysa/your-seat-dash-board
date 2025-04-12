import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/widgets/movie_photo.dart';

class MovieStates extends StatelessWidget {
  const MovieStates({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      height: 400.h,
      color: const Color(0xFFf3f3f3),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Movie States",
            style: TextStyle(
              color: Colors.black,
              fontSize: 5.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Scrollbar(
      thumbVisibility: true,
      radius: Radius.circular(8.r),
      thickness: 8.w,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          dataRowMinHeight: 40.h,
          dataRowMaxHeight: 70.h,
          horizontalMargin: 6.w,
          columnSpacing: 6.w,
          columns: [
            _buildHeader('No.'),
            _buildHeader('User no.'),
            _buildHeader('         Movies'),
            _buildHeader('      Status'),
            _buildHeader('Earning'),
            _buildHeader('Details'),
          ],
          rows: _buildRows(),
        ),
      ),
    );
  }

  DataColumn _buildHeader(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 5.sp,
        ),
      ),
    );
  }

  List<DataRow> _buildRows() {
    final List<Map<String, dynamic>> data = [
      {
        'no': '01',
        'userNo': '6465',
        'title': 'Avengers: Infinity War',
        'image': 'assets/images/Avengers.png',
        'available': true,
        'earning': '\$35.44',
      },
      {
        'no': '02',
        'userNo': '5665',
        'title': 'Guardian Of The Galaxy',
        'image': 'assets/images/Guardian.png',
        'available': false,
        'earning': '\$0.00',
      },
      {
        'no': '03',
        'userNo': '1755',
        'title': 'Avatar 2: The Way Of Water',
        'image': 'assets/images/Avatar.png',
        'available': true,
        'earning': '\$23.50',
      },
    ];

    return data.map((item) {
      return DataRow(
        cells: [
          DataCell(_buildText(item['no'] as String)),
          DataCell(_buildUserCell(item['userNo'] as String)),
          DataCell(_buildMovieCell(item['image'] as String, item['title'] as String)),
          DataCell(_buildStatusCell(item['available'] as bool)),
          DataCell(_buildText(item['earning'] as String)),
          DataCell(_buildDetailsButton()),
        ],
      );
    }).toList();
  }

  Widget _buildText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        text,
        style: TextStyle(color: const Color(0xFF656575), fontSize: 5.sp),
      ),
    );
  }

  Widget _buildUserCell(String userNo) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          userNo,
          style: TextStyle(color: const Color(0xFF656575), fontSize: 5.sp),
        ),
      ),
    );
  }

  Widget _buildMovieCell(String imagePath, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          MoviePhoto(imagePath: imagePath),
          SizedBox(width: 1.w),
          Flexible(
            child: Text(
              title,
              style: TextStyle(color: Colors.black87, fontSize: 5.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCell(bool isAvailable) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: isAvailable ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          isAvailable ? 'Available' : 'Unavailable',
          style: TextStyle(
            color: const Color(0xFF656575),
            fontSize: 5.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF560B76),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Details',
            style: TextStyle(color: Colors.white, fontSize: 5.sp),
          ),
        ),
      ),
    );
  }
}
