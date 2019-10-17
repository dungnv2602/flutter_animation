import 'package:flutter/material.dart';

import 'loader_02.dart';
import 'loader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColorLoader2(),
      ),
    );
  }
}
