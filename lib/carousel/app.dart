import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentPage,
      keepPage: true,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildPage(BuildContext context, int index) {
    return AnimatedBuilder(
      animation: controller,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage((index % 2 == 0) ? 'assets/girl.jpeg' : 'assets/girls.jpeg'), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 4.0,
              color: Colors.black12,
            )
          ],
        ),
      ),
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * .4)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            width: Curves.easeOut.transform(value) * 280,
            height: Curves.easeOut.transform(value) * 360,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          controller: controller,
          itemBuilder: _buildPage,
        ),
      ),
    ));
  }
}
