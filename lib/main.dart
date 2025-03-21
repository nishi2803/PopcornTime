import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_bloc.dart';
import 'package:popcorn_time/presentation%20/main_screen/movie_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*
  kReleaseMode ? await dotenv.load(fileName: ".env") :  await dotenv.load(fileName: ".env.development");
*/
      () => runApp(
        MultiBlocProvider(
          providers: [

             BlocProvider(create: (context) => MovieBloc())
          ],
          child: const MyApp(),
        ),
  );

}




class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,

              title: 'PopcornTime',
              theme: ThemeData(
                fontFamily: 'Mulish',
                useMaterial3: true,
              ),
              home: MovieListScreen()
          );
        });
  }
}