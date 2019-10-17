import 'package:flutter/material.dart';

class GoogleBottomBar extends StatefulWidget {
  final List<GoogleBottomBarItem> items;
  final Duration duration;
  final int selectedIndex;
  final GoogleBottomBarStyle style;
  final ValueChanged<int> onTap;

  const GoogleBottomBar(
      {Key key,
      @required this.items,
      this.selectedIndex = 0,
      this.duration = const Duration(milliseconds: 200),
      this.style = const GoogleBottomBarStyle(fontSize: 18, iconSize: 32, fontWeight: FontWeight.w600),
      this.onTap})
      : super(key: key);

  @override
  _GoogleBottomBarState createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 12, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = [];
    for (int index = 0; index < widget.items.length; index++) {
      GoogleBottomBarItem item = widget.items[index];
      final isSelected = widget.selectedIndex == index;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          widget.onTap(index);
        },
        child: AnimatedContainer(
          duration: widget.duration,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? item.color.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                item.iconData,
                color: isSelected ? item.color : Colors.black,
              ),
              SizedBox(width: 12),
              AnimatedSize(
                vsync: this,
                curve: Curves.easeInOut,
                duration: widget.duration,
                child: Text(
                  isSelected ? item.text : '',
                  style: TextStyle(
                    color: item.color,
                    fontWeight: widget.style.fontWeight,
                    fontSize: widget.style.fontSize,
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}

class GoogleBottomBarItem {
  final String text;
  final IconData iconData;
  final Color color;

  const GoogleBottomBarItem({this.text, this.iconData, this.color});
}

class GoogleBottomBarStyle {
  final double fontSize;
  final double iconSize;
  final FontWeight fontWeight;

  const GoogleBottomBarStyle({this.fontSize, this.iconSize, this.fontWeight});
}
