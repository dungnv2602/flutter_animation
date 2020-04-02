import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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
