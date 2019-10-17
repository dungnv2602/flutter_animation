import 'package:flutter/material.dart';

import 'google_bottom_bar.dart';

/// Source: https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern
/// Code: https://github.com/TechieBlossom/simpleanimations/blob/animated_bottom_bar/lib/bottom_bar_navigation_pattern/animated_bottom_bar.dart
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int selectedBottomBarIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedBottomBarIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: barItems[index].color,
          );
        },
        itemCount: barItems.length,
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedBottomBarIndex = index;
          });
        },
      ),
      bottomNavigationBar: GoogleBottomBar(
        items: barItems,
        duration: Duration(milliseconds: 300),
        selectedIndex: selectedBottomBarIndex,
        onTap: (index) {
          setState(() {
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}

final List<GoogleBottomBarItem> barItems = [
  GoogleBottomBarItem(
    text: "Home",
    iconData: Icons.home,
    color: Colors.indigo,
  ),
  GoogleBottomBarItem(
    text: "Likes",
    iconData: Icons.favorite_border,
    color: Colors.pinkAccent,
  ),
  GoogleBottomBarItem(
    text: "Search",
    iconData: Icons.search,
    color: Colors.yellow.shade900,
  ),
  GoogleBottomBarItem(
    text: "Profile",
    iconData: Icons.person_outline,
    color: Colors.teal,
  ),
];
