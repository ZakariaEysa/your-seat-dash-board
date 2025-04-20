import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/home/presentation/views/home_screen.dart';
import 'package:yourseatgraduationproject/features/admin_flow/movie_detail/presentation/view/movie_details.dart';
import 'package:yourseatgraduationproject/features/admin_flow/signin/view/signin.dart';
import 'package:yourseatgraduationproject/widgets/list/list.dart';
import 'features/admin_flow/homepage/widgets/MoviStates.dart';
import 'features/admin_flow/homepage/widgets/booking_states.dart';
import 'features/admin_flow/homepage/widgets/sales-overview.dart';

import 'firebase_options.dart';
import 'services/simple_bloc_observer_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ScreenUtil.ensureScreenSize();

  SimpleBlocObserverService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), 
      minTextAdapt: true, 
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Admin Dashboard",
          theme: ThemeData.dark(),
          home: NavigationList(),
        );
      },
    );
  }
}
