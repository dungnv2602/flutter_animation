import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation valueChangedAnimation;
  AnimationController animationController;

  bool isDownloadCompleted = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));

    valueChangedAnimation = IntTween(
      begin: 1,
      end: 100,
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isDownloadCompleted = true;
          });
        }
      });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Center(
            child: isDownloadCompleted
                ? Text('DOWNLOAD COMPLETED')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('DOWNLOADING...'),
                      Text(valueChangedAnimation.value.toString()),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
