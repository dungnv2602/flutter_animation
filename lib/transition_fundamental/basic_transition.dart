import 'package:flutter/material.dart';
import '../login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      })
      ..addStatusListener((status) {
        print('$status');
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeTransitionWidget(animation: _animationController),
    );
  }
}

class ScaleTransitionWidget extends StatelessWidget {
  final Animation animation;

  const ScaleTransitionWidget({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut)),
      child: LoginPage(),
    );
  }
}

class ScaleTransitionWidget2 extends StatelessWidget {
  final Animation animation;
  final Animation tween;

  ScaleTransitionWidget2({Key key, this.animation})
      : tween =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: tween.value,
          child: LoginPage(),
        );
      },
    );
  }
}

class FadeTransitionWidget extends StatelessWidget {
  final Animation animation;

  const FadeTransitionWidget({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: LoginPage(),
    );
  }
}

class RotationTransitionWidget extends StatelessWidget {
  final Animation animation;

  const RotationTransitionWidget({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(parent: animation, curve: Curves.elasticOut),
      child: LoginPage(),
    );
  }
}

class SizeTransitionWidget extends StatelessWidget {
  final Animation animation;

  const SizeTransitionWidget({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    return Center(
//      child: SizeTransition(
//        axis: Axis.vertical,
//        axisAlignment: 0,
//        sizeFactor: animation,
//        child: LoginPage(),
//      ),
//    );
    return SizeTransition(
      axis: Axis.horizontal,
      axisAlignment: -1,
      sizeFactor: animation,
      child: LoginPage(),
    );
  }
}

class SlideTransitionWidget extends StatelessWidget {
  final Animation animation;

  const SlideTransitionWidget({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
          .animate(CurvedAnimation(parent: animation, curve: Curves.elasticIn)),
      child: LoginPage(),
    );
  }
}

class SlideTransitionWidget2 extends StatelessWidget {
  final Animation animation;
  final Animation<Offset> tween;

  SlideTransitionWidget2({Key key, this.animation})
      : tween = Tween<Offset>(begin: Offset(-50, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(parent: animation, curve: Curves.elasticIn)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(tween.value.dx, 0, 0),
          child: LoginPage(),
        );
      },
    );
  }
}

class SlideTransitionWidget3 extends StatelessWidget {
  final Animation animation;
  final Animation<Offset> tween;

  SlideTransitionWidget3({Key key, this.animation})
      : tween = Tween<Offset>(begin: Offset(-50, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(parent: animation, curve: Curves.elasticIn)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: tween.value,
          child: LoginPage(),
        );
      },
    );
  }
}

class DecoratedBoxTransitionWidget extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> _opacity;
  final Animation<double> _width;
  final Animation<double> _height;
  final Animation<EdgeInsets> _padding;
  final Animation<BorderRadius> _borderRadius;
  final Animation<Color> _color;

  static CurvedAnimation _buildCurvedIntervalAnimation({parent: Animation, begin: double, end: double}) {
    return CurvedAnimation(parent: parent, curve: Interval(begin, end, curve: Curves.easeIn));
  }

  DecoratedBoxTransitionWidget({Key key, this.animation})
      : _opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(_buildCurvedIntervalAnimation(parent: animation, begin: 0.0, end: 0.100)),
        _width = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(_buildCurvedIntervalAnimation(parent: animation, begin: 0.125, end: 0.250)),
        _height = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(_buildCurvedIntervalAnimation(parent: animation, begin: 0.250, end: 0.375)),
        _padding = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 16.0),
          end: const EdgeInsets.only(bottom: 75.0),
        ).animate(_buildCurvedIntervalAnimation(parent: animation, begin: 0.375, end: 0.500)),
        _borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4.0),
          end: BorderRadius.circular(75.0),
        ).animate(_buildCurvedIntervalAnimation(parent: animation, begin: 0.500, end: 0.750)),
        _color = ColorTween(
          begin: Colors.indigo[100],
          end: Colors.indigo[400],
        ).animate(_buildCurvedIntervalAnimation(parent: animation, begin: 0.500, end: 0.750)),
        super(key: key);

  /// This function is called each time the controller "ticks" a new frame.
  /// When it runs, all of the animation's values will have been
  /// updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      padding: _padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: _opacity.value,
        child: Container(
          width: _width.value,
          height: _height.value,
          decoration: BoxDecoration(
              color: _color.value,
              border: Border.all(color: Colors.indigo[300], width: 3.0),
              borderRadius: _borderRadius.value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: animation,
    );
  }
}

class PositionedTransitionWidget extends StatefulWidget {
  @override
  _PositionedTransitionWidgetState createState() => _PositionedTransitionWidgetState();
}

class _PositionedTransitionWidgetState extends State<PositionedTransitionWidget> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  static const _PANEL_HEADER_HEIGHT = 48.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addStatusListener((status) {
        print('$status');
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double topBefore = height - _PANEL_HEADER_HEIGHT;
    print('topBefore: $topBefore');
    final double bottom = -_PANEL_HEADER_HEIGHT;
    print('bottom: $bottom');
    final double topAfter = _PANEL_HEADER_HEIGHT;
    print('topAfter: $bottom');

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, topBefore, 0.0, bottom),
      end: RelativeRect.fromLTRB(0.0, topAfter, 0.0, 0.0),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _animationController.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    final ThemeData theme = Theme.of(context);
    return Container(
      color: theme.primaryColor,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  child: InkWell(
                    child: Container(
                      width: 100.0,
                      height: 25.0,
                      alignment: Alignment.center,
                      child: const Text(
                        '# item1',
                        style: TextStyle(color: Colors.white, fontFamily: 'RobotoMono', fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          PositionedTransition(
            rect: animation,
            child: Material(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(_PANEL_HEADER_HEIGHT))),
              elevation: 16.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _PANEL_HEADER_HEIGHT,
                    child: Center(
                      child: const Text('panel'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: const Text('content'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Backdrop'),
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _animationController.view,
          ),
          onPressed: () {
            _animationController.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
          },
        ),
      ),
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}
