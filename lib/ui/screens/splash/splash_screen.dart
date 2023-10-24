import 'package:flutter/material.dart';
import 'package:movie_app_route_project/layout/home_layout.dart';

import '../../app_assets.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(AppAssets.splash)),
      ),
    );

    //   Scaffold(
    //   body: Image.asset(AppAssets.splash,
    //     fit: BoxFit.fill)
    // );
  }
}
