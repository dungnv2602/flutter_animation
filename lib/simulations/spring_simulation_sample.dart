import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  Alignment dragAlignment = Alignment.center;

  AnimationController controller;
  Animation<Alignment> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.addListener(() {
      setState(() {
        dragAlignment = animation.value;
      });
    });
  }

  void triggerAnimation(Offset pixelsPerSecond) {
    animation = controller.drive(
      AlignmentTween(
        begin: dragAlignment,
        end: Alignment.center,
      ),
    );

    // Calculate the velocity relative to the unit interval, [0,1]
    final unitsPerSecondX = pixelsPerSecond.dx / width;
    final unitsPerSecondY = pixelsPerSecond.dy / height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    // configuration for spring simulation
    const spring = SpringDescription(
      mass: 30, // how heavy the spring
      stiffness: 1, // how quickly the spring contract (the bounce)
      damping: 1, // determine the number of bounces => lower more bouncy
    );

    final simulation = SpringSimulation(
      spring,
      0, // start point
      1, // end point
      -unitVelocity, // velocity
    );

    controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            final Offset delta = details.delta;
            debugPrint('delta: ${delta.toString()}');

            final desAlignment = Alignment(
              delta.dx / (width / 2),
              delta.dy / (height / 2),
            );
            debugPrint('desAlignment: ${desAlignment.toString()}');

            dragAlignment += desAlignment;
            debugPrint('dragAlignment: ${dragAlignment.toString()}');
          });
        },
        onPanEnd: (details) {
          triggerAnimation(details.velocity.pixelsPerSecond);
        },
        onPanDown: (_) {
          controller.stop();
        },
        child: Align(
          alignment: dragAlignment,
          child: Card(
            child: FlutterLogo(size: 128),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
