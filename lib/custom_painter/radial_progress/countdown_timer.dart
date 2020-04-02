import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    final duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 60), value: 1.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CustomPaint(
                            painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.black12,
                              foregroundColor: Theme.of(context).indicatorColor,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            timerString,
                            style: Theme.of(context).textTheme.display4,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      'isAnimating: ${controller.isAnimating}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 24),
                    FloatingActionButton(
                      onPressed: () {
                        if (controller.isAnimating) {
                          controller.stop();
                        } else {
                          controller.reverse(
                              from: controller.value == 0
                                  ? 1.0
                                  : controller.value);
                        }
                      },
                      child: Icon(
                        controller.isAnimating ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color foregroundColor;

  TimerPainter({this.animation, this.backgroundColor, this.foregroundColor})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;

    canvas.drawCircle(center, radius, paint..color = backgroundColor);

    double progress = animation.value * pi * 2;

    // final angle = Angle.fromTurns(animation.value);
    // print('animation.value: ${animation.value}');
    // print('angle: $angle');
    // print('progress: ${angle.radians}');

    final startAngle = -pi / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      progress,
      false,
      paint..color = foregroundColor,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) =>
      animation.value != oldDelegate.animation.value ||
      backgroundColor != oldDelegate.backgroundColor ||
      foregroundColor != oldDelegate.foregroundColor;

  @override
  bool shouldRebuildSemantics(TimerPainter oldDelegate) => false;
}
