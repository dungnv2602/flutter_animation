import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double topZero = 0;
  double topOne = 0;
  double topTwo = 0;
  double topThree = 0;
  double topFour = 0;
  double topFive = 0;
  double topSix = 0;
  double topSeven = 0;
  double topEight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            /// move normal
            topEight -= notification.scrollDelta / 1;

            /// move slower 1.5 times than normal
            topSeven -= notification.scrollDelta / 1.5;

            /// move slower 2 times than normal
            topSix -= notification.scrollDelta / 2;

            /// move slower 2.5 times than normal
            topFive -= notification.scrollDelta / 2.5;

            /// move slower 3 times than normal
            topFour -= notification.scrollDelta / 3;

            /// move slower 3.5 times than normal
            topThree -= notification.scrollDelta / 3.5;

            /// move slower 4 times than normal
            topTwo -= notification.scrollDelta / 4;

            /// move slower 4.5 times than normal
            topOne -= notification.scrollDelta / 4.5;

            /// move slower 5 times than normal
            topZero -= notification.scrollDelta / 5;
          });
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ParallaxWidget(top: topZero, imgUrl: 'assets/parallax0.png'),
          ParallaxWidget(top: topOne, imgUrl: 'assets/parallax1.png'),
          ParallaxWidget(top: topTwo, imgUrl: 'assets/parallax2.png'),
          ParallaxWidget(top: topThree, imgUrl: 'assets/parallax3.png'),
          ParallaxWidget(top: topFour, imgUrl: 'assets/parallax4.png'),
          ParallaxWidget(top: topFive, imgUrl: 'assets/parallax5.png'),
          ParallaxWidget(top: topSix, imgUrl: 'assets/parallax6.png'),
          ParallaxWidget(top: topSeven, imgUrl: 'assets/parallax7.png'),
          ParallaxWidget(top: topEight, imgUrl: 'assets/parallax8.png'),
          ListView(
            children: <Widget>[
              Container(
                height: 600,
                color: Colors.transparent,
              ),
              Container(
                color: Color(0xff210002),
                width: double.infinity,
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Parallax In",
                      style: TextStyle(fontSize: 30, letterSpacing: 1.8, color: Color(0xffffaf00)),
                    ),
                    Text(
                      "Flutter",
                      style: TextStyle(fontSize: 51, letterSpacing: 1.8, color: Color(0xffffaf00)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 190,
                      child: Divider(
                        height: 1,
                        color: Color(0xffffaf00),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class ParallaxWidget extends StatelessWidget {
  final double top;
  final String imgUrl;

  const ParallaxWidget({Key key, this.top, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Container(
        height: 550,
        child: Image.asset(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
