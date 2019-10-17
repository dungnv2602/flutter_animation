import 'package:flutter/material.dart';

class RotationRoute extends PageRouteBuilder {
  final Widget widget;

  RotationRoute(this.widget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => RotationTransition(
            turns: animation,
            child: child,
          ),
        );
}
