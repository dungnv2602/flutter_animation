import 'package:flutter/material.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController();

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        pageSnapping: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Sample1(),
          Sample2(),
          Sample3(),
        ],
        onPageChanged: (index) => setState(() => page = index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.airline_seat_flat), title: const Text('Sample1')),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: const Text('Sample2')),
          BottomNavigationBarItem(icon: Icon(Icons.print), title: const Text('Sample3')),
        ],
        onTap: (index) {
          setState(() {
            page = index;
            controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}

class Sample1 extends StatelessWidget {
  final controller = ScrollController();
  final itemHeight = 50.0;
  final itemCount = 20;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (_, child) {
              final progressBarWidth = controller.offset * width / (itemHeight * itemCount);
              return Container(
                height: 24,
                width: progressBarWidth,
                color: Colors.green,
              );
            },
          ),
          ListView(
            controller: controller,
            itemExtent: itemHeight,
            children: List.generate(itemCount, (index) => ListTile(title: Text(index.toString()))),
          )
        ],
      ),
    );
  }
}

class Sample2 extends StatefulWidget {
  @override
  _Sample2State createState() => _Sample2State();
}

class _Sample2State extends State<Sample2> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation = Tween<double>(begin: 0, end: 50).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Container(color: Colors.red), preferredSize: Size.fromHeight(animation.value)),
      body: NotificationListener(
        onNotification: (notification) {
          if ((notification.scrollDelta < 0) && (animation.isDismissed)) {
            controller.forward();
          } else if ((notification.scrollDelta > 0) && (animation.isCompleted)) {
            controller.reverse();
          }
          return;
        },
        child: ListView(
          children: List.generate(200, (index) => ListTile(title: Text(index.toString()))),
        ),
      ),
      bottomNavigationBar: Container(height: animation.value, color: Colors.red),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class Sample3 extends StatefulWidget {
  @override
  _Sample3State createState() => _Sample3State();
}

class _Sample3State extends State<Sample3> {
  final controller = ScrollController();
  double appBarHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: appBarHeight,
            floating: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double percent = ((constraints.maxHeight - kToolbarHeight) * 100 / (appBarHeight - kToolbarHeight));
                return Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/head-background.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),

//                    Custom Paint
                    Container(
                      height: kToolbarHeight,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomPaint(
                                size: Size.fromHeight(kToolbarHeight),
                                painter: CirclePainter(100 - percent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

//                    Text and Icon
                    Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Container(
                        height: kToolbarHeight,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Flutter is Awesome ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.animateTo(-appBarHeight,
                                    duration: Duration(seconds: 4), curve: Curves.fastOutSlowIn);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return ListTile(title: Text("Flutter / $index"));
          }))
        ],
      ),
    );
  }
}

///math math
class CirclePainter extends CustomPainter {
  double overallPercent;

  CirclePainter(this.overallPercent);

  @override
  void paint(Canvas canvas, Size size) {
    double circleSize = 25.0;
    double angle = math.pi / 180.0 * ((overallPercent * 360 / 100));
    double line = overallPercent * (size.width - circleSize) / 100;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final path = Path();
    if (overallPercent < 50) {
      path.addPolygon([
        Offset(0.0, size.height),
        Offset((line * 2), size.height),
      ], false);
    }
    if (overallPercent > 50) {
      path.arcTo(Rect.fromLTWH(size.width - (circleSize * 2), 0.0, circleSize * 2, size.height), math.pi / 2,
          -angle * 2, false);
      if (overallPercent < 100) {
        path.addPolygon([
          Offset(overallPercent * (size.width - circleSize) / 100, size.height),
          Offset(size.width - circleSize, size.height),
        ], false);
      }
      if (overallPercent == 100) {
        path.addArc(
            Rect.fromLTWH(size.width - (circleSize * 2), 0.0, circleSize * 2, size.height), math.pi / 2, math.pi * 2);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
