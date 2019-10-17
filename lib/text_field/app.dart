import 'package:flutter/material.dart';
import 'package:flutter_animation/raised_gradient_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    animation = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    delayedAnimation = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.5, 1.0, curve: Curves.easeOut)));

    muchDelayedAnimation = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.8, 1.0, curve: Curves.easeOut)));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform(
                    transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        const Text('Login',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                shadows: [BoxShadow(color: Colors.black12, blurRadius: 1.5, offset: Offset(0, 1.5))])),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Username'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(delayedAnimation.value * width, 0.0, 0.0),
                    child: RaisedGradientButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        gradient:
                            LinearGradient(colors: <Color>[Colors.amber[300], Colors.amber[600], Colors.amber[900]]),
                        onPressed: () {
                          print('LOGIN button clicked');
                        }),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(muchDelayedAnimation.value * width, 0.0, 0.0),
                    child: RaisedGradientButton(
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(color: Colors.white),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[Colors.teal[300], Colors.teal[600], Colors.teal[900]],
                        ),
                        onPressed: () {
                          print('SIGNUP button clicked');
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
