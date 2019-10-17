import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class PageViewNotifier extends ChangeNotifier {
  bool _isPageViewVisible = false;
  bool _isPageViewIgnoreClickable = true;
  double _pageViewOpacity = 0;

  PageController pageController = PageController();

  ScrollController gridController = ScrollController();

  double get pageViewOpacity => _pageViewOpacity;

  bool get isPageViewIgnoreClickable => _isPageViewIgnoreClickable;

  bool get isPageViewVisible => _isPageViewVisible;

  void showPageViewAtIndex(int index) {
    pageController.jumpToPage(index);
    _setPageViewVisible = true;
  }

  void hidePageViewAtIndex(BuildContext context) {
    _scrollGridToIndex(pageController.page.round(), context);
    _setPageViewVisible = false;
  }

  set _setPageViewVisible(bool value) {
    _isPageViewVisible = value;
    _isPageViewIgnoreClickable = !value;
    _pageViewOpacity = value ? 1 : 0;
    notifyListeners();
  }

  void _scrollGridToIndex(int index, BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width / 2;
    int row = index ~/ 2; // divide and take in integer
    row -= 1; // -1 to get row to center of the screen
    final target = cardWidth * row; // card width = height
    final offset = max(gridController.position.minScrollExtent, min(target, gridController.position.maxScrollExtent));
    // jump to target
    gridController.jumpTo(offset);
  }
}
