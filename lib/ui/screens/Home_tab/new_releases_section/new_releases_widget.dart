import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/new_releases_section/new_releases_movie_widget.dart';

import '../../../../models/movie_model.dart';

class NewReleasesWidget extends StatefulWidget {

List<Movie>movies;

NewReleasesWidget(this.movies);

  @override
  State<NewReleasesWidget> createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
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
            child: Text('New Releases',
              style: TextStyle(color: Colors.white, fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              disableCenter: false,
              height: MediaQuery.of(context).size.height * 0.35,
              viewportFraction: 0.4,
            ),
            items: widget.movies.map((movie){
              return Builder(
                builder: (BuildContext context) {
                  return NewReleasesMovieWidget(movie);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
