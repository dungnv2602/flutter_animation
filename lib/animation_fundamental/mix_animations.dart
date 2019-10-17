import 'package:flutter/material.dart';
import '../raised_gradient_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation slideAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    slideAnimation = Tween<double>(
      begin: 0.0,
      end: -0.2,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedGradientButton(
                  width: 150.0,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: const Text('HIDE'),
                  gradient: LinearGradient(
                    colors: <Color>[Colors.amber[300], Colors.amber[600], Colors.amber[900]],
                  ),
                  onPressed: () {
                    animationController.reverse();
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    animationController.forward();
                  },
                  child: Container(
                    transform: Matrix4.translationValues(0.0, slideAnimation.value * height, 0.0),
                    width: 200.0,
                    height: 200.0,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
