import 'package:flutter/material.dart';
import 'package:movie_app_route_project/models/category_model.dart';
import '../../../api/api_manager.dart';
import 'categori_item.dart';
class BrowseTab extends StatefulWidget {
  List <Genres>cateegory=[];

  BrowseTab({super.key});



  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<String> imgs = [
    'assets/action.png',
    'assets/adventure.jpg',
    'assets/animation.jpg',
    'assets/comedy.jpg',
    'assets/crime.jpg',
    'assets/documentry.jpg',
    'assets/mystery.jpg',
    'assets/fammily.jpg',
    'assets/fantasy.jpg',
    'assets/history.jpg',
    'assets/horror.jpg',
    'assets/music.jpg',
    'assets/music.jpg',
    'assets/romance.jpg',
    'assets/science-fiction.jpg',
    'assets/tvmovie.jpg',
    'assets/trailler.jpg',
    'assets/war.jpg',
    'assets/wastern.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Browse Category ",
          style: TextStyle(fontWeight: FontWeight.w700,
              fontSize: 22),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Category>(
              future: ApiManager.getCategoryMovies(),
              builder: (context, snapShot) {
                if(snapShot.hasError){
                  return Center(child: Text('${snapShot.error}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                  );
                }
                else if (snapShot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 187, 59, 1.0),
                  ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                      itemCount: snapShot.data!.genres!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32,
                      ),
                      itemBuilder: (context, index) => CategoryItem(snapShot.data!.genres![index],imgs[index])
                  ),
                );
              }
          ),
        ),
      )
    ],);
  }
}