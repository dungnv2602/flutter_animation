import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WavyHeaderImage(),
    );
  }
}

class MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: const FractionalOffset(0, 2 / 3),
        width: 40,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[6],
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close),
      ),
    );
  }
}

class WavyHeaderImage extends StatelessWidget {
  const WavyHeaderImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Image.asset('assets/images/base/coffee_header.jpeg'),
      clipBehavior: Clip.antiAlias,
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    return bottomWavePath1(size, path);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => this != oldClipper;
}

Path trianglePath(Size size, Path path) {
  path.lineTo(size.width / 2, size.height);
  path.lineTo(size.width, 0);
  path.close();
  return path;
}

Path arcPath1(Size size, Path path) {
  path.lineTo(0, size.height);
  path.quadraticBezierTo(
      size.width / 2, size.height - 100, size.width, size.height);
  path.lineTo(size.width, 0);
  path.close();
  return path;
}

Path arcPath2(Size size, Path path) {
  path.lineTo(0, size.height - 100);
  path.quadraticBezierTo(
      size.width / 2, size.height, size.width, size.height - 100);
  path.lineTo(size.width, 0);
  return path;
}

Path bottomWavePath1(Size size, Path path) {
  /// draw a straight line from current point to the bottom left corner minus 20 for wave
  path.lineTo(0, size.height - 20);

  final firstControlPoint = Offset(size.width / 4, size.height);
  final firstEndPoint = Offset(size.width / 2.25, size.height - 30);
  path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
      firstEndPoint.dx, firstEndPoint.dy);

  final secondControlPoint =
      Offset(size.width - size.width / 3.25, size.height - 65);
  final secondEndPoint = Offset(size.width, size.height - 40);
  path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
      secondEndPoint.dx, secondEndPoint.dy);

  /// draw a straight line from current point to the top right corner. minus 40 for wave
  path.lineTo(size.width, 0);
  path.close();
  return path;
}

Path bottomWavePath2(Size size, Path path) {
  path.lineTo(0, size.height);
  path.quadraticBezierTo(
      0.25 * size.width, size.height - 40, size.width * 0.5, size.height - 20);
  path.quadraticBezierTo(
      0.75 * size.width, size.height, size.width, size.height - 30);
  path.lineTo(size.width, 0);
  path.close();
  return path;
}

Path multiplePointedEdgePath(Size size, Path path) {
  path.lineTo(0, size.height);
  var curXPos = 0.0;
  var curYPos = size.height;
  var increment = size.width / 40;
  while (curXPos < size.width) {
    curXPos += increment;
    curYPos = curYPos == size.height ? size.height - 30 : size.height;
    path.lineTo(curXPos, curYPos);
  }
  path.lineTo(size.width, 0);
  path.close();
  return path;
}

Path multipleRoundedCurvesPath(Size size, Path path) {
  path.lineTo(0, size.height);
  var curXPos = 0.0;
  var curYPos = size.height;
  var increment = size.width / 20;
  while (curXPos < size.width) {
    curXPos += increment;
    path.arcToPoint(Offset(curXPos, curYPos), radius: Radius.circular(5));
  }
  path.lineTo(size.width, 0);
  path.close();
  return path;
}
