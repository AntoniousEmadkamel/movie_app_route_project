import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/recommended_section/recommended_movie_widget.dart';

import '../../../../models/movie_model.dart';

class RecommendedWidget extends StatefulWidget {
  List<Movie> movies;
  String sectionName;

  RecommendedWidget(this.movies, this.sectionName);

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Color.fromARGB(255, 40, 42, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.sectionName,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              disableCenter: false,
              height: MediaQuery.of(context).size.height * 0.45,
              viewportFraction: 0.4,
            ),
            items: widget.movies.map((movie){
              return Builder(
                builder: (BuildContext context) {
                  return RecommendedMovieWidget(movie);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
