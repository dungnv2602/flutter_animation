import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///The ScrollController used in this application was mainly used to control the NestedScrollView Widget. This widget allows us to safely embed a scrolling widget into another scrolling widget and have the two widgets interact with one another. In our case, the NestedScrollView is used to collapse the SliverAppBar which sits at the top of our application's viewport.
      body: NestedScrollView(
        controller: scrollController, // handle scrolling
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text('Tab Controller Example'),
              floating: true,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              expandedHeight: 400,
              flexibleSpace: Image.asset(
                'assets/coffee.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              bottom: TabBar(
                controller: tabController,
                tabs: <Widget>[
                  Tab(
                    text: 'Home',
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: 'Example',
                    icon: Icon(Icons.help),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            PageOne(),
            PageTwo(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: () {
                scrollController.animateTo(scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn);
                tabController.animateTo(0, curve: Curves.easeOut, duration: Duration(milliseconds: 250));
              },
              child: Icon(Icons.keyboard_arrow_up, size: 32),
            ),
            InkWell(
              onTap: () {
                tabController.animateTo(1, curve: Curves.easeOut, duration: Duration(milliseconds: 250));
                scrollController.animateTo(scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn);
              },
              child: Icon(Icons.keyboard_arrow_down, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // THIS PARAM IS IMPORTANT
          children: <Widget>[
            Image.asset(
              'assets/girl.jpeg',
              height: 200,
              width: 200.0,
            ),
            Image.asset(
              'assets/girls.jpeg',
              width: 200.0,
              height: 200,
            ),
            Image.asset(
              'assets/images.png',
              width: 200.0,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
