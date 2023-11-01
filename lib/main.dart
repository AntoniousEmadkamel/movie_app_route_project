import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app_route_project/layout/home_layout.dart';
import 'package:movie_app_route_project/shared/styles/mytheme.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/movie_details_screen.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.0);
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            child: child!);
      },

      debugShowCheckedModeBanner: false,
      title: 'Movie_APP_Route_Project',
      theme: MyTheme.Light,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) =>  HomeLayout(),
        MovieDetails.routeName:(context) => MovieDetails(),
      },
    );
  }
}


