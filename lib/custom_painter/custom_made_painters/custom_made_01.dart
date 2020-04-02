import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        foregroundPainter: BluePainter(),
        child: Container(),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    paint.color = Colors.blue.shade700;
    Path background = Path()..addRect(Rect.fromLTRB(0, 0, width, height));
    canvas.drawPath(background, paint);

    paint.color = Colors.blue.shade600;
    Path ovalPath = Path()
      ..moveTo(0, height * 0.2)
      ..quadraticBezierTo(width * 0.5, height * 0.25, width * 0.5, height * 0.5)
      ..quadraticBezierTo(width * 0.5, height * 0.75, width * 0.2, height)
      ..lineTo(0, height)
      ..close();
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(BluePainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(BluePainter oldDelegate) => false;
}
