import 'package:flutter/material.dart';
import 'package:movie_app_route_project/shared/styles/mytheme.dart';
import '../ui/screens/Home_tab/home_tab.dart';
import '../ui/screens/browse_tab/browse_tab.dart';
import '../ui/screens/search_tab/search_tab.dart';
import '../ui/screens/watchlist_fragment/watchlist_fragment.dart';
class HomeLayout extends StatefulWidget {
  static const String routeName = 'Home';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}
class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    WatchlistTab(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage('assets/home.png'),
              size: 40,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage(
                'assets/search.png',
              ),
              size: 40,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage(
                'assets/movie.png',
              ),
              size: 40,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'BROWSE',
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage(
                'assets/bookmarks.png',
              ),
              size: 40,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'WATCHLIST',
          ),
        ],
      ),


      body: tabs[currentIndex],
    );
  }
}
