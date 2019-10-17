import 'package:flutter/material.dart';

class RotationRouteVertical extends PageRouteBuilder {
  final Widget widget;

  RotationRouteVertical(this.widget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => Align(
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: 0.0,
              child: child,
            ),
          ),
        );
}

class RotationRouteHorizontal extends PageRouteBuilder {
  final Widget widget;

  RotationRouteHorizontal(this.widget)
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionDuration: const Duration(milliseconds: 1000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => Align(
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.horizontal,
        axisAlignment: 0.0,
        child: child,
      ),
    ),
  );
}

