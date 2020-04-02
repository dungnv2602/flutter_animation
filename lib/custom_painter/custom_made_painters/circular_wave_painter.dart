import 'package:flutter/material.dart';
import 'dart:math' as Math;

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: CircularWavePainter(),
      ),
    );
  }
}

class CircularWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = size.center(Offset.zero);

    final waveGap = 10.0;
    final maxRadius = hypot(center.dx, center.dy);
    double currentRadius = 0.0;

    while (currentRadius < maxRadius) {
      canvas.drawCircle(center, currentRadius, paint);
      currentRadius += waveGap;
    }

    canvas.drawCircle(center, 100, paint);
  }

  double hypot(double x, double y) {
    return Math.sqrt(x * x + y * y);
  }

  @override
  bool shouldRepaint(CircularWavePainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(CircularWavePainter oldDelegate) => false;
}
