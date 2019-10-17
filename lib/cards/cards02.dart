import 'package:flutter/material.dart';

final imgUrls = <String>[
  'assets/coffee_header.jpeg',
  'assets/girl.jpeg',
  'assets/girls.jpeg',
  'assets/rodion-kutsaev.jpeg',
  'assets/steve-johnson.jpeg'
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(vsync: this, duration: Duration(seconds: 1));

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {});

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  List<Widget> _buildCards() {
    List<Widget> cards = [];
    for (int i = 0; i < imgUrls.length; i++) {
      cards.add(Positioned(
        top: 200.0 + (10 * i),
        right: 32.0 + (10 * i),
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              offset: Offset(4.0, 4.0),
              color: Colors.black12,
            )
          ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imgUrls[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 16),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: const Text('DON\'T'),
                        color: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: const Text('I\'M IN'),
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.5, 1],
                  colors: [
                    Colors.white,
                    Colors.black12,
                  ],
                ),
              ),
            ),
            Stack(
              children: _buildCards(),
            ),
          ],
        ),
      ),
    );
  }
}
