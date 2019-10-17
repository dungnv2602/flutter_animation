import 'package:flutter/material.dart';

// Navigator.push(context, EnterExitRoute(exitPage: this, enterPage: Screen2()))
class EnterExitRoute extends PageRouteBuilder {
  final Widget exitWidget;
  final Widget enterWidget;

  EnterExitRoute({this.exitWidget, this.enterWidget})
      : super(
          pageBuilder: (_, __, ___) => enterWidget,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, ___) => Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween(
                  begin: Offset.zero,
                  end: const Offset(-1, 0),
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                )),
                child: exitWidget,
              ),
              SlideTransition(
                position: Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                )),
                child: enterWidget,
              ),
            ],
          ),
        );
}

class ScaleRotationRoute extends PageRouteBuilder {
  final Widget widget;

  ScaleRotationRoute(this.widget)
      : super(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) => ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: child,
            ),
          ),
        );
}
