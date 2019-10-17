import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final duration = Duration(milliseconds: 500);
  bool isOn = false;

  void _toggle() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeInOut,
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isOn ? Colors.greenAccent[100] : Colors.redAccent[100].withOpacity(0.5),
          ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: duration,
                curve: Curves.easeInOut,
                top: 3,
                left: isOn ? 60 : 0,
                right: isOn ? 0 : 60,
                child: InkWell(
                  onTap: _toggle,
                  borderRadius: BorderRadius.circular(24),
                  child: AnimatedSwitcher(
                    duration: duration,
                    child: isOn
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 32,
                            key: UniqueKey(),
                          )
                        : Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                            size: 32,
                            key: UniqueKey(),
                          ),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: animation,
                        child: ScaleTransition(
                          child: child,
                          scale: animation,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
