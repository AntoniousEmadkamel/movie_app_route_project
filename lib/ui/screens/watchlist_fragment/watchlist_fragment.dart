import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_route_project/ui/screens/watchlist_fragment/watchlist_item.dart';

import '../../../database_utils/database_utils.dart';
import '../../../models/movie_model.dart';

class WatchlistTab extends StatefulWidget {
  @override
  State<WatchlistTab> createState() => _WatchlistTabState();
}

class _WatchlistTabState extends State<WatchlistTab> {

  @override
  Widget build(BuildContext context) {
    List<Movie> messages = [];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'WatchList',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: messages.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
            : Expanded(
                child: StreamBuilder<QuerySnapshot<Movie>>(
                  stream: DatabaseUtils.readMoviesFormFirebase2(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Color.fromRGBO(255, 187, 59, 1.0),
                      ));
                    }
                    messages = snapshot.data?.docs
                            .map((task) => task.data())
                            .toList() ??
                        [];
                    setState(() {});
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return WatchListItem(messages[index]);
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
