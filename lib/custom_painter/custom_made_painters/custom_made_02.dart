import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        foregroundPainter: BluePainter(),
        child: Container(height: 500),
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

    final background = Path()..addRect(Rect.fromLTRB(0, 0, width, height));
    canvas.drawPath(background, paint..color = Color(0xFF652A78));

    final redPath = Path()
      ..moveTo(width * 0.95, 0)
      ..quadraticBezierTo(width / 2, height * 0.05, 0, height * 0.9)
      ..lineTo(0, height)
      ..lineTo(width / 4, height)
      ..quadraticBezierTo(width * 0.6, height * 0.6, width, height * 0.55)
      ..lineTo(width, 0)
      ..close();
    canvas.drawPath(redPath, paint..color = Color(0xFFDE3C10));

    final orangePath = Path()
      ..moveTo(0, height * 0.75)
      ..quadraticBezierTo(width / 4, height * 0.8, width * 0.4, height)
      ..lineTo(0, height)
      ..close();
    canvas.drawPath(orangePath, paint..color = Color(0xFFE97A4D));

    final purplePath = Path()
      ..lineTo(width / 2, 0)
      ..quadraticBezierTo(width / 4, height / 3, 0, height / 2)
      ..close();
    canvas.drawPath(purplePath, paint..color = Color(0xFF8132AD));

    final cyanPath = Path()
      ..lineTo(width / 4, 0)
      ..lineTo(0, height * 0.2)
      ..close();
    canvas.drawPath(cyanPath, paint..color = Color(0xFF99D5E5));
  }

  @override
  bool shouldRepaint(BluePainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(BluePainter oldDelegate) => false;
}
