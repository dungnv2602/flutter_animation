import 'package:flutter/material.dart';

class ScrollingSliverFabSample extends StatefulWidget {
  @override
  _ScrollingSliverFabSampleState createState() => _ScrollingSliverFabSampleState();
}

class _ScrollingSliverFabSampleState extends State<ScrollingSliverFabSample> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  'assets/coffee_header.jpeg',
                  fit: BoxFit.cover,
                ),
                collapseMode: CollapseMode.parallax,
              ),
              actions: <Widget>[
                CollapsingFab(controller: controller),
              ],
              leading: CollapsingFab(controller: controller),
              bottom: PreferredSize(
                preferredSize: Size(50, 50),
                child: FractionalTranslation(
                  translation: const Offset(-0.05, 0.5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: CollapsingFab(controller: controller)),
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemExtent: 250.0,
          itemCount: 20,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(10.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
              child: Center(
                child: Text(index.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CollapsingFab extends StatelessWidget {
  final ScrollController controller;

  const CollapsingFab({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CollapsingButton(
      controller: controller,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: RawMaterialButton(
          onPressed: () {},
          shape: CircleBorder(),
          child: Icon(CircleBorder
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CollapsingButton extends StatelessWidget {
  final ScrollController controller;
  final Widget child;

  const CollapsingButton({
    Key key,
    @required this.controller,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scale = 0.0;

    if (controller.hasClients) {
      print('offset: ${controller.offset}');
      scale = 1 - (controller.offset / 150).clamp(0.0, 1.0);
      print('scale: $scale');
    }

    return Transform(
      transform: Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: child,
    );
  }
}
