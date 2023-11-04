import 'package:flutter/material.dart';
import '../../../api/api_manager.dart';
import '../../../models/category_model.dart';
import '../../../shared/styles/colors.dart';
import '../search_tab/search-widget.dart';
class CategoryResult extends StatelessWidget {
  static const String routeName = 'Category Result';

  const CategoryResult({super.key});
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Genres;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: goldcolors),
        centerTitle: true,
        title: Text('${args.name}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          FutureBuilder(
              future: ApiManager.getCategoryMoviesList(args.id),
              builder: (context, snapShot) {
                if(snapShot.hasError){
                  return Center(child: Text('${snapShot.error}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  );
                }
                else if (snapShot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(
                    color: goldcolors,
                  ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    itemCount: snapShot.data!.results!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(color: Colors.black,
                          child: SearchWidget(snapShot.data!.results![index])),
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      color: goldcolors,
                      thickness: 1,
                      indent: 18,
                      endIndent: 18,
                    ),
                  ),
                );
              }
          ),
        ],
      ),

    );
  }
}
