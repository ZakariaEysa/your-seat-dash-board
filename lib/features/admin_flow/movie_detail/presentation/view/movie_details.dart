import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/list/list.dart';
import '../../../moives/view/movies.dart';
import '../widgets/movie_info.dart';
import '../widgets/names.dart';
import '../widgets/story_line.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  static final GlobalKey<MovieInfoScreenState> _movieInfoKey =
  GlobalKey<MovieInfoScreenState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        StoryLine.clearFields();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Container(
              width: 45.w,
              color: const Color(0xFF5A2D82),
              child: NavigationList(),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back, color: Colors.black),
                                  onPressed: () {
                                    StoryLine.clearFields();
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                              MovieInfoScreen(key: _movieInfoKey),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30.w, top: 30.h, bottom: 10.h),
                                child: Text(
                                  "Story Line",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 6.sp,
                                  ),
                                ),
                              ),
                              StoryLine(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 2.w,
                                    top: 20.h,
                                    bottom: 30.h),
                                child: Names(),
                              ),
                              SizedBox(height: 35.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBuilder(
                                    text: 'Add Movie',
                                    onTap: () {
                                      final isMovieInfoValid = _movieInfoKey
                                          .currentState
                                          ?.validateFields() ??
                                          false;
                                      final isNamesValid = Names.validate();
                                      final isStoryLineValid =
                                      StoryLine.validate();

                                      if (isMovieInfoValid &&
                                          isNamesValid &&
                                          isStoryLineValid) {
                                        print('All fields are valid');
                                        // Save data here
                                      } else {
                                        print('Validation failed');
                                      }
                                    },
                                    width: 40.w,
                                    height: 50.h,
                                    buttonColor: Color(0xFF560B76),
                                    borderShape: BorderRadius.circular(10.r),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  ButtonBuilder(
                                    text: 'Cancel',
                                    onTap: () {
                                      StoryLine.clearFields();
                                      Navigator.pop(context);
                                    },
                                    width: 40.w,
                                    height: 50.h,
                                    buttonColor: Color(0xFF560B76),
                                    borderShape: BorderRadius.circular(10.r),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}