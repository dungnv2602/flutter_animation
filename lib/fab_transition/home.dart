import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin<HomeScreen> {
  AnimationController _startAnimationController;
  Animation<double> _backdropOpacity;
  Animation<double> _logoScale;
  Animation<double> _buttonScale;

  AnimationController _buttonAnimationController;
  Animation<Alignment> _buttonAlignmentAnimation;
  Animation<double> _buttonPaddingAnimation;
  Animation<double> _buttonIconOpacityAnimation;
  Animation<double> _buttonCircularAnimation;
  Animation<double> _buttonZoomOutAnimation;

  @override
  void dispose() {
    _startAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// BUTTON ANIMATION
    _buttonAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    _buttonAnimationController.addListener(() {
      if (_buttonAnimationController.isCompleted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    _buttonAlignmentAnimation = AlignmentTween(begin: Alignment.bottomRight, end: Alignment.center).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));

    _buttonPaddingAnimation = Tween<double>(begin: 16, end: 0).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));

    _buttonIconOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));

    _buttonCircularAnimation = Tween<double>(begin: 250, end: 0).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.5, 0.9, curve: Curves.bounceOut)));

    _buttonZoomOutAnimation = Tween<double>(begin: 50, end: 1000).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.5, 0.9, curve: Curves.bounceOut)));

    /// START ANIMATION
    _startAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));

    _backdropOpacity = Tween<double>(begin: 0.8, end: 0.5)
        .animate(CurvedAnimation(parent: _startAnimationController, curve: Interval(0.0, 0.3, curve: Curves.easeOut)));

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _startAnimationController, curve: Interval(0.3, 0.7, curve: Curves.elasticOut)));

    _buttonScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _startAnimationController, curve: Interval(0.7, 1.0, curve: Curves.elasticOut)));

    _startAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _buttonAnimationController,
            builder: (context, child) {
              return Stack(
                alignment: _buttonAlignmentAnimation.value,
                children: <Widget>[
                  /// BACKDROP
                  FadeTransition(
                    opacity: _backdropOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/fab_transition/home.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 32,
                    right: 32,
                    child: SizedBox(
                      width: 320,
                      child: Column(
                        children: <Widget>[
                          /// LOGO
                          ScaleTransition(
                            scale: _logoScale,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(75),
                                  image: DecorationImage(
                                    image: AssetImage('assets/fab_transition/avatar-3.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(8.0, 8.0),
                                      blurRadius: 8.0,
                                      color: Colors.black26,
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  ScaleTransition(
                    scale: _buttonScale,
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: _buttonPaddingAnimation.value, bottom: _buttonPaddingAnimation.value),
                      child: Container(
                        width: _buttonZoomOutAnimation.value,
                        height: _buttonZoomOutAnimation.value,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_buttonCircularAnimation.value),
                            gradient: LinearGradient(colors: [
                              Color(0xFFed3d69),
                              Colors.pinkAccent,
                            ]),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4.0, 4.0),
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Material(
                          borderRadius: BorderRadius.circular(_buttonCircularAnimation.value),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(_buttonCircularAnimation.value),
                            onTap: () {
                              /// ANIMATION
                              _buttonAnimationController.forward();
                            },
                            child: Center(
                              child: Opacity(
                                  opacity: _buttonIconOpacityAnimation.value,
                                  child: Icon(Icons.star, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
