import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'scrolling/scrolling_sliver_fab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScrollingSliverFabSample(),
    );
  }
}
