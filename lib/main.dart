import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcorn_time/hive/hive_service.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_bloc.dart';
import 'package:popcorn_time/presentation%20/main_screen/movie_list.dart';
import 'package:popcorn_time/presentation%20/no_internet_screen.dart' show NoInternetScreen;
import 'package:popcorn_time/utils/navigation_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();
   runApp(
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
          routes: {
            '/noInternet': (context) =>
            const NoInternetScreen(),
          },
              navigatorKey: NavigationService.instance.navigationKey,
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