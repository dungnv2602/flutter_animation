import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 120),
            RaisedButton(
              child: const Text('Scroll Limit Reached'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollLimitReached()));
              },
            ),
            RaisedButton(
              child: const Text('Scroll Movement'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollMovement()));
              },
            ),
            RaisedButton(
              child: const Text('Scroll Status'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollNotifications()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollLimitReached extends StatefulWidget {
  @override
  _ScrollLimitReachedState createState() => _ScrollLimitReachedState();
}

class _ScrollLimitReachedState extends State<ScrollLimitReached> {
  String message = "";
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.blueGrey,
            child: Center(
              child: Text(message, style: TextStyle(color: Colors.white)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(title: Text("Index : $index"));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollMovement extends StatefulWidget {
  @override
  _ScrollMovementState createState() => _ScrollMovementState();
}

class _ScrollMovementState extends State<ScrollMovement> {
  String message = "";
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  /// create a variable in which we define the size of our elements in the list, this variable itemSize we will use also to move that number of pixels up or down.
  final itemSize = 100.0;

  void _moveUp() {
    _controller.animateTo(_controller.offset - itemSize, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void _moveDown() {
    _controller.animateTo(_controller.offset + itemSize, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Movement"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.blueGrey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.fast_rewind, color: Colors.white),
                    onPressed: _moveUp,
                  ),
                  Expanded(
                    child: Center(child: Text(message, style: TextStyle(color: Colors.white))),
                  ),
                  FlatButton(
                    child: Icon(Icons.fast_forward, color: Colors.white),
                    onPressed: _moveDown,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: 30,
              itemExtent: itemSize,
              itemBuilder: (context, index) {
                return ListTile(title: Text("Index : $index"));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollNotifications extends StatefulWidget {
  @override
  _ScrollNotificationsState createState() => _ScrollNotificationsState();
}

class _ScrollNotificationsState extends State<ScrollNotifications> {
  String message = "";

  _onStartScroll(ScrollMetrics metrics) {
    print('METRICS - MIN SCROLL EXTENT: ${metrics.minScrollExtent}');
    print('METRICS - MAX SCROLL EXTENT: ${metrics.maxScrollExtent}');
    print('METRICS - VIEWPORT DIMENSIMON: ${metrics.viewportDimension}');
    print('METRICS - EXTENT INSIDE: ${metrics.extentInside}');
    print('METRICS - AXIS: ${metrics.axis}');
    print('METRICS - AXIS DIRECTION: ${metrics.axisDirection}');

    setState(() {
      message = 'ScrollNotification Start';
    });
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    print('METRICS - EXTENT AFTER: ${metrics.extentAfter}');
    print('METRICS - EXTENT BEFORE: ${metrics.extentBefore}');
    print('METRICS - PIXELS: ${metrics.pixels}');
    print('METRICS - AT EDGE: ${metrics.atEdge}');

    setState(() {
      message = 'ScrollNotification Update';
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      message = 'ScrollNotification End';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.blueGrey,
            child: Center(
              child: Text(message, style: TextStyle(color: Colors.white)),
            ),
          ),
          Expanded(
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  _onStartScroll(scrollNotification.metrics);
                }
                if (scrollNotification is ScrollUpdateNotification) {
                  _onUpdateScroll(scrollNotification.metrics);
                }
                if (scrollNotification is ScrollEndNotification) {
                  _onEndScroll(scrollNotification.metrics);
                }
              },
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("Index : $index"));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
