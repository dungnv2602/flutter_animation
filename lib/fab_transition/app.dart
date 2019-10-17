import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return FadeTransitionRoute(
              builder: (_) => LoginScreen(),
            );
          case '/home':
            return FadeTransitionRoute(
              builder: (_) => HomeScreen(),
            );
          default:
            return FadeTransitionRoute(
              builder: (_) => LoginScreen(),
            );
        }
      },
    );
  }
}

class FadeTransitionRoute extends MaterialPageRoute {
  FadeTransitionRoute({WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: Interval(0.1, 0.1, curve: Curves.easeOut)));
    return FadeTransition(opacity: opacityAnimation, child: child);
  }
}
