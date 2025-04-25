import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../../../../../widgets/validators/Validators.dart';
import '../widgets/movie_info.dart';
import '../widgets/crew_names.dart';
import '../widgets/actornames.dart';
import '../widgets/story_line.dart';

class MovieDetail extends StatefulWidget {
  final Map<String, String> movieData;
  final bool isViewOnly;
  final bool isEditing;


  const MovieDetail({super.key, required this.movieData, this.isViewOnly = false,  this.isEditing = false});

  static final GlobalKey<MovieInfoScreenState> _movieInfoKey = GlobalKey<MovieInfoScreenState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final List<String> _actorNames = [''];
  final TextEditingController _storyLineController = TextEditingController();
  final TextEditingController promoLinkController = TextEditingController();
  String? promoLinkError;

  @override
  void initState() {
    super.initState();
    promoLinkController.text = widget.movieData['promoUrl'] ?? '';
    _storyLineController.text = widget.movieData['storyLine'] ?? '';
  }

  @override
  void dispose() {
    promoLinkController.dispose();
    _storyLineController.dispose();
    super.dispose();
  }

  void onLinkChanged(String value) {
    setState(() {
      promoLinkError = Validators.validateYouTubeLink(value);
    });
  }

  bool validateFields() {
    final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
    final isNamesValid = ActorNames.validate();
    final isStoryLineValid = StoryLine.validate();
    final isCrewValid = CrewNames.crewKey.currentState?.widget.validate() ?? false;

    return isMovieInfoValid &&
        isNamesValid &&
        isStoryLineValid &&
        isCrewValid &&
        promoLinkError == null;
  }
  @override
  Widget build(BuildContext context) {
    final directors = widget.movieData['directors']?.split(',').map((e) => e.trim()).toList() ?? [];
    final actors = widget.movieData['actors']?.split(',').map((e) => e.trim()).toList() ?? [];

    return WillPopScope(
      onWillPop: () async {
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
                      child: Form(
                        key: MovieDetail._formKey,
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 270.w, top: 20.h),
                                    child: ButtonBuilder(
                                      text: 'Back',
                                      onTap: () => Navigator.pop(context),
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
                                  readOnly: widget.isViewOnly,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h, bottom: 30.h),
                                  child: ActorNames(
                                    directors: directors,
                                    actors: actors,
                                    isViewOnly: widget.isViewOnly,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                CrewNames(
                                  key: CrewNames.crewKey,
                                  directorName: widget.movieData['Director Name'] ?? '',
                                  writerName: widget.movieData['Writer Name'] ?? '',
                                  producerName: widget.movieData['Producer Name'] ?? '',
                                  isViewOnly: widget.isViewOnly,
                                ),

                                SizedBox(height: 35.h),

                                if (!widget.isViewOnly)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ButtonBuilder(
                        text: widget.isEditing ? 'Save' : 'Add Movie',
                                        onTap: () {
                                          if (validateFields()) {
                                            print('All fields are valid');
                                            print('Final Promo Link: ${promoLinkController.text}');
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
                                        onTap: () => Navigator.pop(context),
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