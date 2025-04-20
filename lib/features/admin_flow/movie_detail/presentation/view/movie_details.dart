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

  static final GlobalKey<MovieInfoScreenState> _movieInfoKey = GlobalKey<MovieInfoScreenState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        StoryLine.clearFields();
        StoryLine.clearFields();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20.h, right: 120.w),
                                child: Row(
                                  children: [
                                    ButtonBuilder(
                                      onTap: () {
                                        StoryLine.clearFields();
                                        Navigator.pop(context);
                                      },
                                      width: 30.w,
                                      height: 51.h,
                                      buttonColor: const Color(0xFF560B76),
                                      frameColor: const Color(0xFF560B76),
                                      borderShape: BorderRadius.circular(15.r),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 6.sp,
                                      ),
                                      text: 'Back',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              MovieInfoScreen(key: _movieInfoKey),
                              Padding(
                                padding: EdgeInsets.only(left: 30.w, top: 30.h, bottom: 10.h),
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
                                padding: EdgeInsets.only(left: 8.w, right: 2.w, top: 20.h, bottom: 30.h),
                                child: Names(),
                              ),
                              SizedBox(height: 35.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBuilder(
                                    text: 'Add Movie',
                                    onTap: () {
                                      final isMovieInfoValid = _movieInfoKey.currentState?.validateFields() ?? false;
                                      final isNamesValid = Names.validate();
                                      final isStoryLineValid = StoryLine.validate();

                                      if (isMovieInfoValid && isNamesValid && isStoryLineValid) {
                                        print('All fields are valid');
                                      } else {
                                        print('Validation failed');
                                      }
                                    },
                                    width: 40.w,
                                    height: 50.h,
                                    buttonColor: const Color(0xFF560B76),
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
                                    buttonColor: const Color(0xFF560B76),
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
