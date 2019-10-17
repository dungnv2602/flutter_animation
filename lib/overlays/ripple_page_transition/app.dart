import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectkey = RectGetter.createGlobalKey();
  Rect rect;

  void _onTap() async {
    setState(() {
      rect = RectGetter.getRectFromKey(rectkey); // onTap, update rect position
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // on next frame
        setState(() {
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide); // set rect to be as big as possible
          Future.delayed(animationDuration + delay, _nextPage); // go to next page after delay
        });
      });
    });
  }

  void _nextPage() {
    Navigator.of(context).push(FadeRouteBuilder(page: NewPage())).then((_) {
      setState(() {
        rect = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(title: Text('Fab overlay transition')),
          body: Center(child: Text('This is first page')),
          floatingActionButton: RectGetter(
            key: rectkey,
            child: FloatingActionButton(
              onPressed: _onTap,
              child: Icon(Icons.mail_outline),
            ),
          ),
        ),
        RippleWidget(rect: rect, duration: animationDuration),
      ],
    );
  }
}

class RippleWidget extends StatelessWidget {
  final Rect rect;
  final Duration duration;

  const RippleWidget({Key key, @required this.rect, @required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return rect == null
        ? Container()
        : AnimatedPositioned(
            duration: duration,
            left: rect.left,
            right: size.width - rect.right,
            top: rect.top,
            bottom: size.height - rect.bottom,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewPage'),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
