import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: PathPainter(),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Path path = Path();

    relativeConicToPath(path, size);

    canvas.drawPath(path, paint);
  }

  void relativeCubicToPath(Path path, Size size) {
    path.moveTo(size.width / 4, size.height / 4);
    path.relativeCubicTo(size.width / 4, 3 * size.height / 4,
        3 * size.width / 4, size.height / 4, size.width, size.height);
  }

  void relativeConicToPath(Path path, Size size) {
    path.moveTo(size.width / 4, size.height / 4);
    path.relativeConicTo(
        size.width / 4, 3 * size.height / 4, size.width, size.height, 20);
  }

  void relativeQuadraticBezierToPath(Path path, Size size) {
    path.moveTo(size.width / 4, size.height / 4);
    path.relativeQuadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
  }

  void relativeLineToPath(Path path, Size size) {
    path.moveTo(size.width / 4, size.height / 4);
    path.relativeLineTo(size.width / 2, size.height / 2);
  }

  void addRRectPath(Path path, Size size) {
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width / 2, size.height / 2, size.width / 4, size.height / 4),
        Radius.circular(16),
      ),
    );
  }

  void addPolygonPath(Path path, Size size) {
    path.addPolygon([
      Offset.zero,
      Offset(size.width / 4, size.height / 4),
      Offset(size.width / 2, size.height),
    ], false); // set to true if want to close the draw
  }

  void addArcPath(Path path, Size size) {
    /// e.g. For drawing an arc starting from left middle edge to top edge of an oval, we will start from 3.14 which is the radian value for 180 and add 1.57 which is the radian value for 90.
    // path.addArc(Rect.fromLTWH(0, 0, size.width, size.height),
    //     Angle.halfTurn().radians, Angle.quarterTurn().radians);
  }

  void addOvalPath(Path path, Size size) {
    path.addOval(Rect.fromLTWH(
        size.width / 2, size.height / 2, size.width / 4, size.height / 4));
  }

  void addRectPath(Path path, Size size) {
    path.addRect(Rect.fromLTWH(
        size.width / 2, size.height / 2, size.width / 4, size.height / 4));
  }

  void conicToPath(Path path, Size size) {
    /// If the weight is bigger than 1, the drawn shape is a hyperbola.
    /// If the weight is 1, the drawn shape is parabola.
    /// If it’s smaller than 1, the drawn shape would be an ellipse.
    /// As the weight increases, the curve is pulled more to control point.
    final weight = 5.0;
    path.conicTo(
        size.width / 4, size.height * 0.75, size.width, size.height, weight);
  }

  void cubicToPath(Path path, Size size) {
    path.cubicTo(size.width / 4, 0.75 * size.height, 0.75 * size.width,
        size.height / 4, size.width, size.height);
  }

  void quadraticBezierToPath(Path path, Size size) {
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PathPainter oldDelegate) => false;
}
