import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

///set transitionOnUserGestures to true on both Hero widgets to solve back issue on IOS
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
          },
          child: Hero(
              tag: 'hero-icon',
              child: Icon(
                Icons.add,
                size: 50.0,
              ),
              transitionOnUserGestures: true),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final _secondSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),
      transitionOnUserGestures: true);
  final _thirdSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),

      ///Adding placeholders
      ///After the widget flies off the place it used to be in and before the widget arrives at the destination, there is empty space at the destination. We can add a placeholder to this location.
      placeholderBuilder: (context, size, widget) {
        return Container(
          height: size.height,
          width: size.width,
          child: CircularProgressIndicator(),
        );
      },
      transitionOnUserGestures: true);

  final _fourthSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),

      ///Changing the Hero widget
      ///Flutter allows us to change the widget which actually flies from one page to the other without changing the widgets on the two pages.
      ///We do this using the flightShuttleBuilder parameter
      flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
        Icon icon;
        if (direction == HeroFlightDirection.push) {
          icon = Icon(
            FontAwesomeIcons.rocket,
            size: 150.0,
          );
        } else if (direction == HeroFlightDirection.pop) {
          icon = Icon(
            FontAwesomeIcons.rocket,
            size: 70.0,
          );
        }
        return icon;
      },
      transitionOnUserGestures: true);

  final _fifthSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),
      placeholderBuilder: (context, size, widget) {
        return Container(
          height: size.height,
          width: size.width,
          child: CircularProgressIndicator(),
        );
      },
      flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
        Icon icon;
        if (direction == HeroFlightDirection.push) {
          icon = Icon(
            FontAwesomeIcons.rocket,
            size: 150.0,
          );
        } else if (direction == HeroFlightDirection.pop) {
          icon = Icon(
            FontAwesomeIcons.rocket,
            size: 70.0,
          );
        }
        return icon;
      },
      transitionOnUserGestures: true);

  final _sixthSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),
      flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
        final Hero toHero = toContext.widget;
        return RotationTransition(
          turns: animation,
          child: toHero.child,
        );
      },
      transitionOnUserGestures: true);

  final _seventhSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),
      flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
        final Hero toHero = toContext.widget;
        return FadeTransition(
          opacity: animation.drive(Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Interval(0.0, 1.0, curve: ValleyQuadraticCurve())))),
          child: toHero.child,
        );
      },
      transitionOnUserGestures: true);

  final _eightSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 150.0,
      ),
      flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
        final Hero toHero = toContext.widget;
        return ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0, curve: PeakQuadraticCurve()),
              ),
            ),
          ),
          child: toHero.child,
        );
      },
      transitionOnUserGestures: true);

  final _nineSample = Hero(
      tag: 'hero-icon',
      child: Icon(
        Icons.add,
        size: 50.0,
      ),
      flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
        final Hero toHero = toContext.widget;
        return ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0, curve: PeakQuadraticCurve()),
              ),
            ),
          ),
          child: direction == HeroFlightDirection.push
              ? RotationTransition(
            turns: animation,
            child: toHero.child,
          )
              : FadeTransition(
            opacity: animation.drive(
              Tween<double>(begin: 0.0, end: 1.0).chain(
                CurveTween(
                  curve: Interval(0.0, 1.0, curve: ValleyQuadraticCurve()),
                ),
              ),
            ),
            child: toHero.child,
          ),
        );
      },
      transitionOnUserGestures: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _nineSample,
      ),
    );
  }
}

class ValleyQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return 4 * math.pow(t - 0.5, 2);
  }
}

class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -15 * math.pow(t, 2) + 15 * t + 1;
  }
}

void main() => runApp(MaterialApp(
  theme: ThemeData.light(),
  home: FirstScreen(),
));
