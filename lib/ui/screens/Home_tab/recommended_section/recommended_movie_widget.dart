import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/models/movie_model.dart';
import 'package:movie_app_route_project/shared/styles/colors.dart';

import '../../../../database_utils/database_utils.dart';
import '../movie_details_screen.dart';

class RecommendedMovieWidget extends StatefulWidget {
  Movie movie;

  RecommendedMovieWidget(this.movie);

  @override
  State<RecommendedMovieWidget> createState() => _RecommendedMovieWidgetState();
}

class _RecommendedMovieWidgetState extends State<RecommendedMovieWidget> {
  @override
  void initState() {
    super.initState();
    checkMovieInFireStore();
  }
  String img = 'https://image.tmdb.org/t/p/w500';
  int movieSelected = 0;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10,left: 10),
      color: Color.fromRGBO(52, 53, 52, 1.0),
      clipBehavior: Clip.antiAlias,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MovieDetails.routeName,
                      arguments: widget.movie);
                },
                child: CachedNetworkImage(
                  imageUrl: "$img${widget.movie.posterPath}",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image:
                            DecorationImage(image: imageProvider, fit: BoxFit.fill),
                      ),
                    );
                  },
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    movieSelected = 1 - movieSelected;
                    if(movieSelected==1){
                      DatabaseUtils.AddMoviesToFirebase(widget.movie);
                    }else{
                      DatabaseUtils.DeleteMovie("${widget.movie.DataBaseId}");
                    }
                    setState(() {

                    });
                  },
                  child: movieSelected == 0
                      ? Image.asset("assets/bookmark.png")
                      : Image.asset("assets/bookmarkSelected.png")),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/star.png",width: 32),
              Text("${widget.movie.voteAverage!.toStringAsFixed(1)}",style: TextStyle(
                fontSize: 16,
                color: Colors.white
              ),),
            ],
          ),
          SizedBox(height: 4,),
          Text('  ${widget.movie.title}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("  ${widget.movie.releaseDate!.substring(0,4)}",style:TextStyle(color: Colors.grey,fontSize: 12) , ),
          ),
        ],
      ),
    );
  }
  Future<void> checkMovieInFireStore ()async{
    QuerySnapshot<Movie> temp= await DatabaseUtils.readMovieFormFirebase(widget.movie.id!);
    if(temp.docs.isEmpty){
    }else{
      widget.movie.DataBaseId=temp.docs[0].data().DataBaseId;
      movieSelected=1;
      setState(() {
      });
    }
  }
}
