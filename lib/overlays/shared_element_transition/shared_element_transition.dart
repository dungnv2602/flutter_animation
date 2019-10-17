import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'page_view_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageViewNotifier>(
      builder: (_) => PageViewNotifier(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GridViewImages(),
            PageViewImages(),
          ],
        ),
      ),
    );
  }
}

class GridViewImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        controller: Provider.of<PageViewNotifier>(context, listen: false).gridController,
        physics: ClampingScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Provider.of<PageViewNotifier>(context)
                .showPageViewAtIndex(index), // on GridView item click, show PageView
            child: Card(
              child: Center(
                child: RectGetter(
                  key: gridKeys[index],
                  child: Image.asset(
                    "assets/overlays/${images[index]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
      ),
    );
  }
}

class PageViewImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageViewNotifier>(
        builder: (context, notifier, child) {
          return WillPopScope(
            onWillPop: () async {
              // on back press
              if (notifier.isPageViewVisible) {
                // if page view is visible
                notifier.hidePageViewAtIndex(context); // hide page view
                return false; // and don't close app
              }
              return true; // otherwise close app
            },
            child: Opacity(
              opacity: notifier.pageViewOpacity,
              child: IgnorePointer(
                ignoring:
                    notifier.isPageViewIgnoreClickable, // make PageView ignore the clicks when invisible and vice versa
                child: child,
              ),
            ),
          );
        },
        child: PageView.builder(
          pageSnapping: true,
          physics: ClampingScrollPhysics(),
          controller: Provider.of<PageViewNotifier>(context, listen: false).pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Center(
              child: RectGetter(
                key: pageKeys[index],
                child: Image.asset(
                  "assets/overlays/${images[index]}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            );
          },
        ));
  }
}

List gridKeys = List.generate(images.length, (i) => RectGetter.createGlobalKey());
List pageKeys = List.generate(images.length, (i) => RectGetter.createGlobalKey());

List<String> images = [
  'animal.jpg',
  'beetle.jpg',
  'bug.jpg',
  'butterfly_1.jpg',
  'butterfly_dolls.jpg',
  'dragonfly_1.jpg',
  'dragonfly_2.jpg',
  'dragonfly_3.jpg',
  'grasshopper.jpg',
  'hover_fly.jpg',
  'hoverfly.jpg',
  'insect.jpg',
  'morpho.jpg',
  'nature.jpg'
];
