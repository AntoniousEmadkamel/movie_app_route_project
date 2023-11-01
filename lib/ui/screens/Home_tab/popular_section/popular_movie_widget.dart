import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/movie_details_screen.dart';

import '../../../../models/movie_model.dart';

class PopularMovieWidget extends StatefulWidget {
  Movie movie;

  PopularMovieWidget(this.movie);

  @override
  State<PopularMovieWidget> createState() => _PopularMovieWidgetState();
}

class _PopularMovieWidgetState extends State<PopularMovieWidget> {
  String img = 'https://image.tmdb.org/t/p/w500';
  int movieSelected = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "$img${widget.movie.backdropPath}",
          imageBuilder: (context, imageProvider) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height * 0.26,
          left:MediaQuery.of(context).size.height * 0.15 ,
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, MovieDetails.routeName,
                    arguments: widget.movie);
              },
              child: Image.asset("assets/playbutton.png")),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.30,
          top: MediaQuery.of(context).size.height * 0.13,
          left:MediaQuery.of(context).size.height * 0.010 ,
          child: CachedNetworkImage(
            imageUrl: "$img${widget.movie.posterPath}",
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
            placeholder: (context, url) => CircularProgressIndicator(),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.02,
          child: InkWell(
              onTap: () {
                movieSelected = 1 - movieSelected;
                setState(() {

                });
              },
              child: movieSelected == 0
                  ? Image.asset("assets/bookmark.png")
                  : Image.asset("assets/bookmarkSelected.png")),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.31,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text("${widget.movie.title}",style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),maxLines: 1,),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.36,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text("${widget.movie.releaseDate!.substring(0,4)} PG-13 ${widget.movie.originalLanguage}",
            style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          ),
        ),
      ],
    );
  }
}
