import 'package:flutter/material.dart';
import 'dart:math' as Math;

class SmileyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = Math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    /// draw the body
    final paint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, paint);

    /// draw the mouth
    final smilePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius / 2,
        ),
        0,
        Math.pi,
        false,
        smilePaint);

    /// draw the eyes
    canvas.drawCircle(
        Offset(center.dx - radius / 2, center.dy - radius / 2), 10, Paint());
    canvas.drawCircle(
        Offset(center.dx + radius / 2, center.dy - radius / 2), 10, Paint());
  }

  @override
  bool shouldRepaint(SmileyFacePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SmileyFacePainter oldDelegate) => false;
}
