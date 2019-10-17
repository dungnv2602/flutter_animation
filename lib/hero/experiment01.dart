import 'package:flutter/material.dart';
import 'package:flutter_animation/route_transition/slide_transition.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('HOME'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
            return DetailPage();
          }));
        },
        heroTag: 'hero-fab',
        child: Icon(Icons.send),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'hero-fab',
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25),
              elevation: 4.0,
              child: Container(
                width: 50,
                height: 50,
              ),
            ),
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              final Hero toHero = toContext.widget;
              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.00,
                      0.50,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 1.5,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(
                        0.50,
                        1.00,
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                  child: toHero.child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
