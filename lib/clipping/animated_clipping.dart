import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> firstEndPointAnimation;
  Animation<double> firstControlPointAnimation;
  Animation<double> secondControlPointAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    firstEndPointAnimation = Tween<double>(
      begin: 2.25,
      end: 2.0,
    ).animate(curvedAnimation);

    firstControlPointAnimation = Tween<double>(
      begin: 0.0,
      end: 65.0,
    ).animate(curvedAnimation);

    secondControlPointAnimation = Tween<double>(
      begin: 65.0,
      end: 0.0,
    ).animate(curvedAnimation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

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
        child: Image.asset('assets/coffee_header.jpeg'),
        builder: (context, child) {
          return ClipPath(
            child: child,
            clipper: AnimatedBottomWave(
                firstEndPointAnimation.value,
                firstControlPointAnimation.value,
                secondControlPointAnimation.value),
          );
        },
      ),
    );
  }
}

class AnimatedBottomWave extends CustomClipper<Path> {
  final double firstEndPointAnimationValue;
  final double firstControlPointAnimationValue;
  final double secondControlPointAnimationValue;

  AnimatedBottomWave(
      this.firstEndPointAnimationValue,
      this.firstControlPointAnimationValue,
      this.secondControlPointAnimationValue);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30.0);

    var firstControlPoint =
        Offset(size.width / 4.0, size.height - firstControlPointAnimationValue);

    var firstEndPoint =
        Offset(size.width / firstEndPointAnimationValue, size.height - 30.0);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25),
        size.height - secondControlPointAnimationValue);

    var secondEndPoint = Offset(size.width, size.height - 30.0);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
//    return this != oldClipper;
    return false;
  }
}
