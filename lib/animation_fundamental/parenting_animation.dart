import 'package:flutter/material.dart';
import '../login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation slideAnimation, scaleAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    slideAnimation = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    scaleAnimation = Tween<double>(begin: 20.0, end: 300.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Scaffold(
          body: Transform(
            transform: Matrix4.translationValues(slideAnimation.value * width, 0.0, 0.0),
            child: AnimatedBuilder(
              child: LoginPage(),
              animation: scaleAnimation,
              builder: (context, child) {
                return Container(
                  width: scaleAnimation.value,
                  height: scaleAnimation.value,
                  child: child,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
