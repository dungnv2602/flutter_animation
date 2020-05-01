import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 100.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        height: 200,
        width: 200,
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) => AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              foregroundPainter: RadialProgressPainter(
                backgroundColor: Colors.black12,
                progressColor: Colors.amber,
                currentProgress: animation.value,
                strokeWidth: 8.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  color: Colors.purple,
                  splashColor: Colors.blueAccent,
                  shape: CircleBorder(),
                  child: const Text('Click Me'),
                  onPressed: () {
                    if (animation.value == 100.0) {
                      controller.reverse();
                    } else {
                      controller.forward();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class RadialProgressPainter extends CustomPainter {
  final Color backgroundColor;
  final Color progressColor;
  final double currentProgress;
  final double strokeWidth;

  const RadialProgressPainter({
    this.backgroundColor,
    this.progressColor,
    this.currentProgress,
    this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    Paint completePaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    /// circle is in the center of the container
    Offset center = Offset(size.width / 2, size.height / 2);

    /// radius is the minimum of the half of the strokeWidth and the height, now we are taking a minimum of both as the container might not be a square always
    double radius = min(size.width / 2, size.height / 2);

    /// draw the full circle
    canvas.drawCircle(center, radius, linePaint);

    double arcAngle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // start angle is at the top
      arcAngle, // sweep angle for drawArc, which is how much the arc should extend too
      false, // don’t want the end of the arc to be connected back to the centre
      completePaint,
    );
  }

  @override
  bool shouldRepaint(RadialProgressPainter oldDelegate) => this != oldDelegate;

  @override
  bool shouldRebuildSemantics(RadialProgressPainter oldDelegate) => false;
}
