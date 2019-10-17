import 'package:flutter/material.dart';
import 'consts.dart';

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
