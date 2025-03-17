import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/text_field/text_field/new_text_field_builder.dart';

class Names extends StatefulWidget {
  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  List<Widget> directorTextFields = [];
  List<Widget> actorTextFields = [];

  @override
  void initState() {
    super.initState();
    _addInitialDirectorTextField();
    _addInitialActorTextField();
  }

  void _addInitialDirectorTextField() {
    directorTextFields.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/director.png'),
                radius: 14.r,
              ),
              SizedBox(width: 3.w),
              Text(
                'director name',
                style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                onPressed: _addDirectorTextField,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
            child: SizedBox(width: 350, height: 70, child: NewTextField()),
          ),
        ],
      ),
    );
  }

  void _addInitialActorTextField() {
    actorTextFields.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/director.png'),
                radius: 14,
              ),
              SizedBox(width: 3.w),
              Text(
                'Actor name',
                style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                onPressed: _addActorTextField,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
            child: SizedBox(width: 350.w, height: 70.h, child: NewTextField()),
          ),
        ],
      ),
    );
  }

  void _addDirectorTextField() {
    setState(() {
      directorTextFields.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/director.png'),
                  radius: 14,
                ),
                SizedBox(width: 3.w),
                Text(
                  'director name',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: _addDirectorTextField,
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
                child: SizedBox(width: 350.w, height: 70.h, child: NewTextField())),
          ],
        ),
      );
    });
  }

  void _addActorTextField() {
    setState(() {
      actorTextFields.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/director.png'),
                  radius: 14.r,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Actor name',
                  style: TextStyle(
                      fontSize: 6.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: _addActorTextField,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
              child: SizedBox(width: 350.w, height: 70.h, child: NewTextField()),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding on the whole container
      padding:  EdgeInsets.symmetric(horizontal: 25.h),
      child: Container(
        width: 220.w,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(10.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...directorTextFields,
                ],
              ),
            ),
            SizedBox(width: 20.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...actorTextFields,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
