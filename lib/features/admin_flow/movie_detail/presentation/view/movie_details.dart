import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_cubit.dart';
import '../../../../../widgets/button/button_builder.dart';
import '../widgets/crew_names.dart';
import '../widgets/movie_info.dart';
import '../widgets/actor_names.dart';
import '../widgets/story_line.dart';

class MovieDetail extends StatefulWidget {
  final Map<String, String> movieData;
  final bool isViewOnly;
  final bool isEditing;
  const MovieDetail({super.key, required this.movieData, this.isViewOnly = false,this.isEditing = false,});

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
        StoryLine.clearFields(context);
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
                                    onTap: () {

                                      // Cancel logic
                                      StoryLine.clearFields(context);
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
                                padding: EdgeInsets.only(left: 70.w, top: 30.h, bottom: 10.h),
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
                                child: ActorNames(

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
                              SizedBox(height: 60.h),

                              if (!widget.isViewOnly)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // ButtonBuilder(
                                    //   text: 'Add Movie',
                                    //   onTap: () {
                                    //     MovieCubit.get(context).printControllers();
                                    //     final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
                                    //     final isNamesValid = Names.validate();
                                    //     final isStoryLineValid = StoryLine.validate();
                                    //
                                    //     if (isMovieInfoValid && isNamesValid && isStoryLineValid && promoLinkError == null) {
                                    //       print('All fields are valid');
                                    //       print('Final Promo Link: ${promoLinkController.text}');
                                    //       // Save or update movie logic here
                                    //     } else {
                                    //       print('Validation failed');
                                    //     }
                                    //   },
                                    //   width: 40.w,
                                    //   height: 50.h,
                                    //   buttonColor: const Color(0xFF560B76),
                                    //   borderShape: BorderRadius.circular(10.r),
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 7.sp,
                                    //   ),
                                    // ),
                                    ButtonBuilder(
                      text: widget.isEditing ? 'Save' : 'Add Movie',
                                      onTap: () {

                                        // التحقق من صحة البيانات
                                        final isMovieInfoValid = MovieDetail._movieInfoKey.currentState?.validateFields() ?? false;
                                        final isNamesValid = ActorNames.validate();
                                        final isStoryLineValid = StoryLine.validate();
                                        final isCrewValid = CrewNames.crewKey.currentState?.widget.validate() ?? false;

                                        if (isMovieInfoValid && isNamesValid && isStoryLineValid&&isCrewValid && promoLinkError == null) {
                                          MovieCubit.get(context).uploadMovieToFirestore();

                                          print('All fields are valid');

                                          MovieCubit.get(context).printControllers();

                                          print('Final Promo Link: ${promoLinkController.text}');

                                          // بعد الفاليديشن الصحيح، استدعاء دالة رفع الفيلم
                                          MovieCubit.get(context).uploadMovieToFirestore();
                                        } else {
                                          print('Validation failed');
                                        }
                                        MovieCubit.get(context).uploadMovieToFirestore();
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
                                        StoryLine.clearFields(context);
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
                              const SizedBox(height: 10),
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
