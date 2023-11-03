import 'package:flutter/material.dart';
import 'package:movie_app_route_project/ui/screens/search_tab/search-widget.dart';

import '../../../api/api_manager.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool? isSelected = false;
  String query = '';
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(18, 19, 18, 1.0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Container(
          margin: const EdgeInsets.all(6),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
            controller: search,
            onFieldSubmitted: (String userInput) {
              setState(() {
                isSelected = false ;
              });
            },
            onTap: () {
              isSelected = true;
              setState(() {});
            },
            onChanged: (value) {
              // isSelected = true;
              query = value;
              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
              ),
              filled: true,
              fillColor: const Color.fromRGBO(81, 79, 79, 1.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 35,
                  ),
                  color: Colors.white,
                ),
              ),
              suffixIcon: isSelected!
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          query = '';
                          search.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 32,
                        ),
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox.shrink(),
              hintText: 'Search',
              hintStyle: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(18, 19, 18, 1.0),
      body: query.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/iconmaterial.png')),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'No Movies Found',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  ),
                ),
              ],
            )
          : FutureBuilder(
              future: ApiManager.getSearchMovies(query),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return Center(
                    child: Text(
                      '${snapShot.error}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  );
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(255, 187, 59, 1.0),
                    ),
                  );
                }
                return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                    itemCount: snapShot.data!.results!.length,
                    itemBuilder: (context, index) {
                      return SearchWidget(snapShot.data!.results![index]);
                    });
              }),
    );
  }
}
