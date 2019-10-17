import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final appBar = AppBar(
  backgroundColor: Colors.white,
  elevation: 0.0,
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios),
    color: Colors.black,
    onPressed: () {},
  ),
  title: const Text(
    'Near By',
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  ),
  actions: <Widget>[
    IconButton(
      color: Colors.black,
      icon: Icon(Icons.present_to_all),
      iconSize: 36.0,
      onPressed: () {},
    )
  ],
);

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _cardAnimation, _delayedCardAnimation, _infoAnimation, _fabAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _cardAnimation = Tween<double>(begin: 0.0, end: -0.02)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _delayedCardAnimation = Tween<double>(begin: 0.0, end: -0.04)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _infoAnimation = Tween<double>(begin: 0.0, end: 0.06)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _fabAnimation = Tween<double>(begin: 1.0, end: -0.01).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildStackCard(
      {@required double width, @required double height, @required String imgUrl, Matrix4 transform}) {
    return Container(
      transform: transform,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imgUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black12,
            spreadRadius: 1.0,
          )
        ],
      ),
    );
  }

  Widget _buildInfoCard({Matrix4 transform}) {
    return Container(
      transform: transform,
      width: 260.0,
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black12,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('XOXO', style: TextStyle(fontSize: 24.0)),
                SizedBox(width: 4.0),
                Image.asset(
                  'assets/simbolo.png',
                  height: 20.0,
                  width: 20.0,
                ),
                SizedBox(width: 80.0),
                Text('10.0km', style: TextStyle(fontSize: 22.0, color: Colors.grey)),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Fate is wonderful.',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFAB({Icon icon, bool mini}) {
    return FloatingActionButton(
      onPressed: () {},
      child: icon,
      backgroundColor: Colors.white,
      mini: mini,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Scaffold(
          appBar: appBar,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                child: Stack(
                  /// set this in order for the info to visible
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      left: 20.0,
                      child: _buildStackCard(
                        width: 260.0,
                        height: 400.0,
                        imgUrl: 'assets/girl.jpeg',
                        transform: Matrix4.translationValues(0.0, _delayedCardAnimation.value * height, 0.0),
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      child: _buildStackCard(
                        width: 280.0,
                        height: 400.0,
                        imgUrl: 'assets/girls.jpeg',
                        transform: Matrix4.translationValues(0.0, _cardAnimation.value * height, 0.0),
                      ),
                    ),
                    Positioned(
                      child: _buildStackCard(
                        width: 300.0,
                        height: 400.0,
                        imgUrl: 'assets/girl.jpeg',
                      ),
                    ),
                    Positioned(
                      top: 320.0,
                      left: 20.0,
                      child: _buildInfoCard(
                        transform: Matrix4.translationValues(0.0, _infoAnimation.value * height, 0.0),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, _fabAnimation.value * height, 0.0),
                padding: EdgeInsets.symmetric(horizontal: 48.0),
                margin: EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildFAB(icon: Icon(Icons.close, color: Colors.black), mini: true),
                    _buildFAB(icon: Icon(Icons.chat_bubble_outline, color: Colors.blueAccent), mini: false),
                    _buildFAB(icon: Icon(Icons.favorite_border, color: Colors.pink), mini: true),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
