import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin<LoginScreen> {
  AnimationController _startAnimationController;
  Animation<double> _backdropOpacity;
  Animation<double> _logoScale;
  Animation<Offset> _fieldsSlide;
  Animation<Offset> _buttonSlide;

  AnimationController _buttonAnimationController;
  Animation<double> _buttonSqueezeAnimation;
  Animation<double> _buttonCircularInAnimation;
  Animation<double> _buttonCircularOutAnimation;
  Animation<double> _buttonPaddingAnimation;
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
    _buttonAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));

    _buttonAnimationController.addListener(() {
      if (_buttonAnimationController.isCompleted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    _buttonSqueezeAnimation = Tween<double>(begin: 320, end: 50).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.0, 0.25, curve: Curves.bounceOut)));

    _buttonCircularInAnimation = Tween<double>(begin: 8, end: 50).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.0, 0.25, curve: Curves.fastOutSlowIn)));

    _buttonPaddingAnimation = Tween<double>(begin: 350, end: 0).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.55, 0.75, curve: Curves.fastOutSlowIn)));

    _buttonCircularOutAnimation = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.75, 0.9, curve: Curves.fastOutSlowIn)));

    _buttonZoomOutAnimation = Tween<double>(begin: 50, end: 1000).animate(
        CurvedAnimation(parent: _buttonAnimationController, curve: Interval(0.75, 0.9, curve: Curves.bounceOut)));

    _startAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));

    _backdropOpacity = Tween<double>(begin: 0.5, end: 0.3)
        .animate(CurvedAnimation(parent: _startAnimationController, curve: Interval(0.0, 0.3, curve: Curves.easeOut)));

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _startAnimationController, curve: Interval(0.3, 0.7, curve: Curves.elasticOut)));

    _fieldsSlide = Tween<Offset>(begin: Offset(-1.5, 0.0), end: Offset(0.0, 0.0)).animate(
        CurvedAnimation(parent: _startAnimationController, curve: Interval(0.5, 1.0, curve: Curves.elasticOut)));

    _buttonSlide = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(
        CurvedAnimation(parent: _startAnimationController, curve: Interval(0.5, 1.0, curve: Curves.elasticOut)));

    _startAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            /// BACKDROP
            FadeTransition(
              opacity: _backdropOpacity,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fab_transition/login.jpg'),
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
                      child: Image.asset(
                        'assets/fab_transition/tick.png',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    SizedBox(height: 16),

                    /// FIELDS
                    SlideTransition(
                      position: _fieldsSlide,
                      child: LoginForm(),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 16,
              right: 16,
              bottom: 120,
              child: SlideTransition(
                  position: _buttonSlide, child: Center(child: const Text('Dont have an account? Sign Up'))),
            ),

            /// BUTTON
            SlideTransition(
              position: _buttonSlide,
              child: AnimatedBuilder(
                animation: _buttonAnimationController,
                builder: (context, child) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: _buttonPaddingAnimation.value),
                      child: Hero(
                        tag: 'fly',
                        child: Container(
                          width: _buttonZoomOutAnimation.value == 50
                              ? _buttonSqueezeAnimation.value
                              : _buttonZoomOutAnimation.value,
                          height: _buttonZoomOutAnimation.value == 50 ? 50 : _buttonZoomOutAnimation.value,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(_buttonZoomOutAnimation.value == 50
                                  ? _buttonCircularInAnimation.value
                                  : _buttonCircularOutAnimation.value),
                              gradient: LinearGradient(colors: [
                                Color(0xFFed3d69),
                                Colors.pinkAccent,
                              ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.3),
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,
                                )
                              ]),
                          child: Material(
                            borderRadius: BorderRadius.circular(_buttonCircularInAnimation.value),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(_buttonCircularInAnimation.value),
                              onTap: () {
                                /// ANIMATION
                                print('ONTAP');
                                _buttonAnimationController.forward();
                              },
                              child: Center(
                                child: _buttonSqueezeAnimation.value > 75.0
                                    ? Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )
                                    : _buttonZoomOutAnimation.value <= 300
                                        ? CircularProgressIndicator(strokeWidth: 2.0)
                                        : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'LOGIN',
          style: TextStyle(fontSize: 32, letterSpacing: 6),
        ),
        SizedBox(height: 48),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            labelText: 'Email',
            hintText: 'joe@gmail.com',
            labelStyle: TextStyle(fontSize: 24, letterSpacing: 2, color: Colors.white),
            hintStyle: TextStyle(fontSize: 14),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: 24, letterSpacing: 2, color: Colors.white),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
