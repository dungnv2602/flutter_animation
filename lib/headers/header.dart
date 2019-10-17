import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        child: Image.asset('assets/coffee_header.jpeg'),
        clipper: ExperimentClipper(),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30.0);

    var firstControlPoint = Offset(size.width / 4.0, size.height);

    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65.0);

    var secondEndPoint = Offset(size.width, size.height - 30.0);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30.0);

    var firstControlPoint = Offset(size.width / 4.0, size.height - 65.0);

    var firstEndPoint = Offset(size.width / 2.0, size.height - 30.0);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height);

    var secondEndPoint = Offset(size.width, size.height - 30.0);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ExperimentClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // triangle
//    path.lineTo(size.width / 2, size.height);
//    path.lineTo(size.width, 0.0);

    // arc 2
//    path.lineTo(0, size.height);
//    path.quadraticBezierTo(
//        size.width / 2, size.height - 100, size.width, size.height);
//    path.lineTo(size.width, 0);

    // arc 3
//    path.lineTo(0, size.height - 100);
//    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 100);
//    path.lineTo(size.width, 0.0);

    // wave
//    path.lineTo(0, size.height);
//    path.quadraticBezierTo(size.width / 4, size.height - 40, size.width / 2, size.height - 20);
//    path.quadraticBezierTo(3 / 4 * size.width, size.height, size.width, size.height - 40);
//    path.lineTo(size.width, 0);

    // wave 2
//    path.lineTo(0, size.height - 40);
//    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 20);
//    path.quadraticBezierTo(3 / 4 * size.width, size.height - 40, size.width, size.height);
//    path.lineTo(size.width, 0);

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
