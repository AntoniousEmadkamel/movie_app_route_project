import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/api/api_manager.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/popular_section/popular_widget.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/recommended_section/recommended_widget.dart';

import '../../../models/movie_model.dart';

import '../../../shared/styles/colors.dart';
import 'new_releases_section/new_releases_widget.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<MoviesModel>(
              future: ApiManager.getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                }
                return PopularWidget(snapshot.data!.results!);
              },
            ),

            //New Releases Movies
            FutureBuilder<MoviesModel>(
                future: ApiManager.getNewReleasesMovies(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    );
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: goldcolors),
                    );
                  }
                  return NewReleasesWidget(snapShot.data!.results!);
                }),


            //Recommended Movies
            FutureBuilder<MoviesModel>(
                future: ApiManager.getTopRatedMovies(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    );
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return RecommendedWidget(snapShot.data!.results!,"Recommended");
                }),
          ],
        ),
      ),
    );
  }
}
