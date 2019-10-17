import 'package:flutter/material.dart';
import 'animated_bottom_tab_bar.dart';
import 'consts.dart';


/// Source: https://dribbble.com/shots/5419022-Tab
/// Code: https://github.com/tunitowen/tab_bar_animation
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: PURPLE,
        title: const Text('Tab Bar Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ANIMATED BOTTOM TAB BAR'),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomTabBar(
        onPressed: (index) {},
      ),
    );
  }
}
