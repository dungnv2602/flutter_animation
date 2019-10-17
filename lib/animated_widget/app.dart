import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Random random = Random();

  double width = 50;
  double height = 50;
  double opacity = 1;
  Color color = Colors.blue;
  BorderRadius borderRadius = BorderRadius.circular(4);
  Alignment alignment = Alignment.topLeft;
  EdgeInsetsGeometry padding = EdgeInsets.symmetric(vertical: 16);
  BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 10),
          blurRadius: 10,
        )
      ]);

  double top = 10;
  double left = 10;
  double right = 10;
  double bottom = 10;

  TextAlign align = TextAlign.left;
  TextStyle style = TextStyle(fontSize: 12, color: Colors.blue);

  bool crossFadeState = false;

  @override
  Widget build(BuildContext context) {
    Widget widget = ContainerDemo(
      key: UniqueKey(),
      width: 200,
      height: 200,
      color: Colors.red,
    );

    return Scaffold(
      body: AnimatedSwitcherWidget(child: widget),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final value = random.nextInt(100);
            widget = ContainerDemo(
                key: Key(value.toString()),
                width: 3.0 * value,
                height: 3.0 * value,
                color: Color.fromARGB(100 + value, 100 + value, 100 + value, 100 + value));
          });
        },
        child: Icon(Icons.play_circle_outline),
      ),
    );
  }
}

class AnimatedSwitcherWidget extends StatelessWidget {
  Widget child;

  AnimatedSwitcherWidget({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        child: child,
        duration: Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            child: child,
            scale: animation,
          );
        },
      ),
    );
  }
}

class ContainerDemo extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const ContainerDemo({Key key, this.width, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: width,
      height: height,
      color: color,
    );
  }
}

class AnimatedCrossFadeWidget extends StatelessWidget {
  final bool state;

  const AnimatedCrossFadeWidget({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedCrossFade(
        firstChild: Container(
          height: 200,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        ),
        secondChild: Container(
          height: 200,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FlutterLogo(),
          ),
        ),
        crossFadeState: !state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}

class AnimatedListWidget extends StatelessWidget {
  final GlobalKey<AnimatedListState> listkey = GlobalKey();

  Widget _buildItem(UserModel user, [int index]) {
    return ListTile(
      key: ValueKey<UserModel>(user),
      title: Text(user.firstName),
      subtitle: Text(user.lastName),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profileImageUrl),
      ),
      onLongPress: () {
        deleteUser(index);
      },
    );
  }

  void addUser() {
    int index = listData.length;
    listData.add(UserModel(
      firstName: 'abcxyz',
      lastName: 'bnmghj',
      profileImageUrl:
          'https://images-prod.healthline.com/hlcmsresource/images/topic_centers/5833-asian_female_laying_down_bed-732x549-thumbnail.jpg',
    ));

    listkey.currentState.insertItem(index, duration: Duration(milliseconds: 500));
  }

  void deleteUser(int index) {
    var user = listData.removeAt(index);
    listkey.currentState.removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
        child: SizeTransition(
          sizeFactor: CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
          axisAlignment: 0.0,
          child: _buildItem(user),
        ),
      );
    }, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedList(
          key: listkey,
          initialItemCount: listData.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(listData[index], index),
            );
          },
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: addUser,
          ),
        ],
      ),
    );
  }
}

class AnimatedContainerWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Alignment alignment;
  final double width;
  final double height;
  final BoxDecoration boxDecoration;

  const AnimatedContainerWidget({Key key, this.padding, this.alignment, this.width, this.height, this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: boxDecoration,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black54,
      ),
    );
  }
}

class AnimatedSizeWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;
  final SingleTickerProviderStateMixin vsync;

  const AnimatedSizeWidget(
      {Key key, @required this.width, @required this.height, this.color, this.borderRadius, @required this.vsync})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: vsync,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color,
          ),
        ),
      ),
    );
  }
}

class AnimatedOpacityWidget extends StatelessWidget {
  final double opacity;
  final SingleTickerProviderStateMixin vsync;

  const AnimatedOpacityWidget({Key key, @required this.opacity, @required this.vsync}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class AnimatedAlignWidget extends StatelessWidget {
  final SingleTickerProviderStateMixin vsync;
  final Alignment alignment;

  const AnimatedAlignWidget({Key key, @required this.vsync, @required this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: alignment,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red,
        ),
      ),
    );
  }
}

class AnimatedPaddingWidget extends StatelessWidget {
  final SingleTickerProviderStateMixin vsync;
  final EdgeInsetsGeometry padding;

  const AnimatedPaddingWidget({Key key, @required this.vsync, @required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: padding,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Center(
        child: Container(
          padding: padding,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class AnimatedPositionedWidget extends StatelessWidget {
  final SingleTickerProviderStateMixin vsync;
  final double top;
  final double left;
  final double bottom;
  final double right;

  const AnimatedPositionedWidget({Key key, @required this.vsync, this.top, this.left, this.bottom, this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          height: 100,
          width: 100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedDefaultTextStyleWidget extends StatelessWidget {
  final TextAlign align;
  final TextStyle style;

  const AnimatedDefaultTextStyleWidget({Key key, this.align, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        width: 500,
        height: 500,
        child: AnimatedDefaultTextStyle(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          textAlign: align,
          child: Text('FLUTTER'),
          style: style,
        ),
      ),
    );
  }
}
