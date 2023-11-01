import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/ui/screens/Home_tab/recommended_section/recommended_widget.dart';

import '../../../api/api_manager.dart';
import '../../../database_utils/database_utils.dart';
import '../../../models/movie_model.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = "Movie details";

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  String img = 'https://image.tmdb.org/t/p/w500';
  int movieSelected = 0;
  bool flag = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Movie;
    if (flag) {
      checkMovieInFireStore(args);
      flag = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${args.title}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.white, size: 28),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "$img${args.backdropPath}",
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 42,
                    )),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.width * 0.45,
                      child: Image.asset('assets/playbutton.png')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                '${args.title}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                '${args.releaseDate!.substring(0, 4)}  PG-13  ${args.originalLanguage}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: [
                        Positioned(
                          width: MediaQuery.of(context).size.width * 0.32,
                          height: MediaQuery.of(context).size.height * 0.28,
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.010,
                          child: CachedNetworkImage(
                            imageUrl: "$img${args.posterPath}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 42,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${args.overview}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/star.png'),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${args.voteAverage!.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            FutureBuilder<MoviesModel>(
                future: ApiManager.getSimilarMovies(args.id),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text(
                        '${snapShot.error}',
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
                  return RecommendedWidget(
                      snapShot.data!.results!, 'More Like This');
                }),
          ],
        ),
      ),
    );
  }

  Future<void> checkMovieInFireStore(Movie mov) async {
    QuerySnapshot<Movie> temp =
        await DatabaseUtils.readMovieFormFirebase(mov.id!);
    if (temp.docs.isEmpty) {
    } else {
      mov.DataBaseId = temp.docs[0].data().DataBaseId;
      movieSelected = 1;
      setState(() {});
    }
  }
}
