import 'package:flutter/material.dart';

///Use this skeleton widget as a placeholder when loading data from an external source.
class Skeleton extends StatefulWidget {
  final double height;
  final double width;

  const Skeleton({Key key, this.height, this.width}) : super(key: key);

  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear))

      ///The addListener() function calls setState(), so every time the Animation generates a new number, the current frame is marked dirty, which forces build() to be called again. In build(), the container changes size because its height and width now use animation.value instead of a hardcoded value. Dispose of the controller when the animation is finished to prevent memory leaks.
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(gradientPosition.value, 0),
              end: Alignment(-1, 0),
              colors: [Colors.black12, Colors.black26, Colors.black12])),
    );
  }
}
