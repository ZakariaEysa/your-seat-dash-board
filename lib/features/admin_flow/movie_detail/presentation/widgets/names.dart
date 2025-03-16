import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/text_field/text_field/new_text_field_builder.dart';

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
                radius: 14,
              ),
              SizedBox(width: 10),
              Text(
                'director name',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                onPressed: _addDirectorTextField,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
            child: SizedBox(
                width: 350, height: 70, child: NewTextField()),
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
              SizedBox(width: 10),
              Text(
                'Actor name',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.black),
                onPressed: _addActorTextField,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
            child: SizedBox(
                width: 350, height: 70, child: NewTextField()),
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
                SizedBox(width: 10),
                Text(
                  'director name',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: _addDirectorTextField,
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
                child: SizedBox(width: 350, height: 70, child: NewTextField())),
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
                  radius: 14,
                ),
                SizedBox(width: 10),
                Text(
                  'Actor name',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black),
                  onPressed: _addActorTextField,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.h),
              child: SizedBox(
                  width: 350, height: 70, child: NewTextField()),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              SizedBox(width: 20),
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
      ),
    );
  }
}