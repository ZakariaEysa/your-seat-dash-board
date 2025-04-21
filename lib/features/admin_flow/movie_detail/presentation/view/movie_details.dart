import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/movie_info.dart';
import '../widgets/names.dart';
import '../widgets/story_line.dart';

class MovieDetail extends StatefulWidget {
  final Map<String, String> movieData;
  final bool isViewOnly;

  const MovieDetail({super.key, required this.movieData, this.isViewOnly = false});

  static final GlobalKey<MovieInfoScreenState> _movieInfoKey = GlobalKey<MovieInfoScreenState>();

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final TextEditingController promoLinkController = TextEditingController();
  String? promoLinkError;

  @override
  void initState() {
    super.initState();
    promoLinkController.text = widget.movieData['promoUrl'] ?? '';
  }

  @override
  void dispose() {
    promoLinkController.dispose();
    super.dispose();
  }

  void onLinkChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        promoLinkError = 'Promo link cannot be empty';
      } else if (!(Uri.tryParse(value)?.hasAbsolutePath ?? false)) {
        promoLinkError = 'Invalid URL format';
      } else {
        promoLinkError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final directors = widget.movieData['directors']?.split(',').map((e) => e.trim()).toList() ?? [];
    final actors = widget.movieData['actors']?.split(',').map((e) => e.trim()).toList() ?? [];

    return WillPopScope(
      onWillPop: () async {
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 260.w, top: 20.h),
                                  child: ButtonBuilder(
                                    text: 'Back',
                                    onTap: () {
                                      // Cancel logic
                                      StoryLine.clearFields();
                                      Navigator.pop(context);
                                    },
                                    width: 30.w,
                                    height: 40.h,
                                    buttonColor: const Color(0xFF560B76),
                                    borderShape: BorderRadius.circular(10.r),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),

                              MovieInfoScreen(
                                key: MovieDetail._movieInfoKey,
                                movieData: widget.movieData,
                                isViewOnly: widget.isViewOnly,
                              ),

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

                              StoryLine(
                                initialValue: widget.movieData['storyLine'] ?? '',
                                readOnly: widget.isViewOnly, // هذا سيجعل الحقل للعرض فقط إذا كان isViewOnly = true
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 2.w, top: 20.h, bottom: 30.h),
                                child: Names(
                                  directors: directors,
                                  actors: actors,
                                  isViewOnly: widget.isViewOnly,
                                ),
                              ),

                              SizedBox(height: 35.h),

                              if (!widget.isViewOnly)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonBuilder(
                                      text: 'Add Movie',
                                      onTap: () {
                                        final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
                                        final isNamesValid = Names.validate();
                                        final isStoryLineValid = StoryLine.validate();

                                        if (isMovieInfoValid && isNamesValid && isStoryLineValid && promoLinkError == null) {
                                          print('All fields are valid');
                                          print('Final Promo Link: ${promoLinkController.text}');
                                          // Save or update movie logic here
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
