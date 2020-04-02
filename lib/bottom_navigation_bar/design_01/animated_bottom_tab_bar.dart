import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class AnimatedBottomTabBar extends StatefulWidget {
  final Function(int) onPressed;

  const AnimatedBottomTabBar({Key key, this.onPressed}) : super(key: key);

  @override
  _AnimatedBottomTabBarState createState() => _AnimatedBottomTabBarState();
}

class _AnimatedBottomTabBarState extends State<AnimatedBottomTabBar>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;

  AnimationController _fadeOutController;
  Animation<double> _fadeFabOutAnimation;
  Animation<double> _fadeFabInAnimation;

  double fabIconAlpha = 1;
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 1;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIMATION_DURATION));

    _fadeOutController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (ANIMATION_DURATION ~/ 5)));

    _positionTween = Tween<double>(begin: 0.0, end: 0.0);
    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _fadeFabOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabOutAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    _fadeFabInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.8, 1.0, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabInAnimation.value;
        });
      });
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();

    _animationController.forward();
    _fadeOutController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 65.0,
          margin: const EdgeInsets.only(top: 45.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -1),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TabItem(
                selected: currentSelected == 0,
                iconData: Icons.home,
                title: 'HOME',
                callbackFunction: () {
                  setState(() {
                    nextIcon = Icons.home;
                    currentSelected = 0;
                  });
                  _initAnimationAndStart(_positionAnimation.value, -1);
                  widget.onPressed(currentSelected);
                },
              ),
              TabItem(
                selected: currentSelected == 1,
                iconData: Icons.search,
                title: 'SEARCH',
                callbackFunction: () {
                  setState(() {
                    nextIcon = Icons.search;
                    currentSelected = 1;
                  });
                  _initAnimationAndStart(_positionAnimation.value, 0);
                  widget.onPressed(currentSelected);
                },
              ),
              TabItem(
                selected: currentSelected == 2,
                iconData: Icons.person,
                title: 'USER',
                callbackFunction: () {
                  setState(() {
                    nextIcon = Icons.person;
                    currentSelected = 2;
                  });
                  _initAnimationAndStart(_positionAnimation.value, 1);
                  widget.onPressed(currentSelected);
                },
              ),
            ],
          ),
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              heightFactor: 1,
              alignment: Alignment(_positionAnimation.value, 0),
              child: FractionallySizedBox(
                widthFactor: 1 / 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90.0,
                      width: 90.0,
                      child: ClipRect(
                        clipper: HalfClipper(),
                        child: Container(
                          child: Center(
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 8.0)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                      width: 90.0,
                      child: CustomPaint(
                        painter: HalfPainter(),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                      width: 60.0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PURPLE,
                            border: Border.all(
                              color: Colors.white,
                              width: 5.0,
                              style: BorderStyle.none,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Opacity(
                            opacity: fabIconAlpha,
                            child: Icon(
                              activeIcon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return this != oldClipper;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
        Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, (size.height / 2));
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, size.height / 2 - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class TabItem extends StatefulWidget {
  final String title;
  final IconData iconData;
  final bool selected;
  final Function callbackFunction;

  const TabItem(
      {Key key,
      @required this.title,
      @required this.iconData,
      @required this.selected,
      @required this.callbackFunction})
      : super(key: key);

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIMATION_DURATION),
              alignment: Alignment(0, textYAlign),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              curve: Curves.easeIn,
              alignment: Alignment(0, iconYAlign),
              duration: Duration(milliseconds: ANIMATION_DURATION),
              child: AnimatedOpacity(
                opacity: iconAlpha,
                duration: Duration(milliseconds: ANIMATION_DURATION),
                child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment(0, 0),
                    icon: Icon(
                      widget.iconData,
                      color: PURPLE,
                    ),
                    onPressed: () {
                      widget.callbackFunction();
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIMATION_DURATION = 300;
const Color PURPLE = Color(0xFF8c77ec);
