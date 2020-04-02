import 'package:flutter/material.dart';
import 'dart:math' as Math;

class RadialProgressPainter extends CustomPainter {
  final Color backgroundColor;
  final Color foregroundColor;
  final double currentProgress; // must be from 0 to 1
  final double strokeWith;

  const RadialProgressPainter({
    @required this.foregroundColor,
    this.backgroundColor = Colors.black12,
    this.currentProgress = 0.0,
    this.strokeWith = 6.0,
  }) : assert(foregroundColor != null);

  @override
  void paint(Canvas canvas, Size size) {
    final Size constrainedSize =
        size - Offset(this.strokeWith, this.strokeWith);
    final shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height); // diameter

    final center = size.center(Offset.zero);
    final radius = shortestSide / 2;

    /// start at the top. 0 radians represents the right edge
    final double startAngle = -Math.pi / 2;
    final double sweepAngle = (Math.pi * 2 * (currentProgress));

    /// if backgroundColor != null => paint background
    /// else do nothing
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWith;

      canvas.drawCircle(center, radius, backgroundPaint);
    }

    /// draw progress
    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWith
      ..shader = LinearGradient(colors: [
        Colors.pink.shade500,
        Colors.blue.shade500,
      ], begin: Alignment.topCenter)
          .createShader(
              Rect.fromCircle(center: center, radius: size.width / 2));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(RadialProgressPainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(RadialProgressPainter oldDelegate) => false;
}
