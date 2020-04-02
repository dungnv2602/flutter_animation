import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  GravitySimulation simulation;

  @override
  void initState() {
    super.initState();

    simulation = GravitySimulation(
      100.0, // acceleration
      0.0, // starting point
      500.0, // end point
      0.0, // starting velocity
    );

    controller = AnimationController(
      vsync: this,
      upperBound:
          500, // default bound is 1 => set to 500 to match the end point
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
