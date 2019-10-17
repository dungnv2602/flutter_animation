import 'package:flutter/material.dart';

class FromLeftRoute extends PageRouteBuilder {
  final Widget widget;

  FromLeftRoute(this.widget)
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                widget,
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              ///Notice that the SlideTransition can be replaced by any other transition widgets provided by Flutter such as ScaleTransition or FadeTransition.
              /// FromLeftRoute
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              );

              /// FromRightRoute
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                child: child,
              );

              /// TopDownRoute
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                child: child,
              );

              /// BottomUpRoute
              return SlideTransition(
                position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
