import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation scaleAnimation, transformAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    scaleAnimation = Tween<double>(
      begin: 20.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    transformAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(125.0),
      end: BorderRadius.circular(0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Center(
            child: Container(
              width: scaleAnimation.value,
              height: scaleAnimation.value,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: transformAnimation.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
