import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// source: https://medium.com/@erdoganbavas/physics-based-animations-in-flutter-1d20130919a1

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  SpringSimulation simulation;

  @override
  void initState() {
    super.initState();

    simulation = SpringSimulation(
      SpringDescription(
        mass: 1, // how heavy the spring
        stiffness: 100, // how quickly the spring contract (the bounce)
        damping: 1, // determine the number of bounces => lower more bouncy
      ),
      0.0, // starting point
      300.0, // ending point
      10, // velocity
    );

    controller = AnimationController(
      vsync: this,
      upperBound:
          500, // upperBound value is bigger than ending point in simulation parameters because of spring’s oscillation
    )..addListener(() {
        setState(() {});
      });

    controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 50,
          top: controller.value,
          height: 10,
          width: 10,
          child: Container(
            color: Colors.redAccent,
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
