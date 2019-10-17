import 'package:flutter/material.dart';

import 'custom_search_delegate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  /// Page controller for the PageView
  final _pageController = PageController(initialPage: 0, keepPage: true);
  final _scrollDirection = Axis.horizontal;

  Color _canvasColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          FirstPage(originalItems: List.generate(30, (i) => 'FirstPage ${i + 1}')),
          SecondPage(originalItems: List.generate(30, (i) => 'SecondPage ${i + 1}')),
          ThirdPage(originalItems: List.generate(30, (i) => 'ThirdPage ${i + 1}')),
        ],
        controller: _pageController,
        scrollDirection: _scrollDirection,
        physics: PageScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: _canvasColor,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text('First Page')),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text('Second Page')),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text('Third Page')),
          ],
          onTap: (int index) {
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
            switch (index) {
              case 0:
                _canvasColor = Colors.teal;
                break;
              case 1:
                _canvasColor = Colors.amber;
                break;
              case 2:
                _canvasColor = Colors.blue;
                break;
              default:
                _canvasColor = Colors.teal;
            }
          },
          currentIndex: _currentIndex,
          elevation: 4.0,
          unselectedIconTheme: IconThemeData(opacity: 0.5, size: 18.0),
          selectedIconTheme: IconThemeData(opacity: 1.0, size: 24.0),
          unselectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
          selectedLabelStyle: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          // type auto change to shifting when 3 or more items specified
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          // this only works if type = shifting
          unselectedItemColor: Colors.white,
          // works with type = shifting
          selectedItemColor: Colors.white, // works with type = shifting
        ),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  final List<String> originalItems;

  const FirstPage({Key key, this.originalItems}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

/// Override AutomaticKeepAliveClientMixin to keep state alive
class _FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin<FirstPage> {
  final _perPage = 10;
  int _present = 0;
  List<String> _items = [];
  bool _reverseSort = false;

  void loadMoreItems() {
    // if reach the last page
    if ((_present + _perPage) > widget.originalItems.length) {
      // add the rest items in original list
      _items.addAll(widget.originalItems.getRange(_present, widget.originalItems.length));
    } else {
      // add more items according to perPage
      _items.addAll(widget.originalItems.getRange(_present, _present + _perPage));
    }
    // increment present
    _present = _present + _perPage;
  }

  bool isLastItem() {
    return _present == widget.originalItems.length;
  }

  @override
  void initState() {
    super.initState();
    loadMoreItems();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    print('ON _handleScrollNotification');
    if (notification.metrics.extentAfter == 0 && !isLastItem()) {
      setState(() {
        loadMoreItems();
        print('ITEMS LENGTH: ${_items.length}');
      });
    }
    return false;
  }

  Future<void> _handleRefresh() {
    /// mock refresh
    return Future<void>.delayed(Duration(milliseconds: 300), () {
      _items = [];
      _present = 0;
      loadMoreItems();
    }).then((_) {
      setState(() {});
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 300),
          content: const Text(
            'Refresh completed!',
            style: TextStyle(color: Colors.amber),
          )));
    });
  }

  void _filterSearch(String query) {
    final dummySearchList = [...widget.originalItems.getRange(0, _present)];
    if (query.isNotEmpty) {
      setState(() {
        _items = dummySearchList.where((item) => item.contains(query)).toList();
      });
    } else {
      setState(() {
        _items = widget.originalItems.getRange(0, _present).toList();
      });
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  void _reverseList() {
    setState(() {
      _reverseSort = !_reverseSort;
      _items.sort((String a, String b) => _reverseSort ? b.compareTo(a) : a.compareTo(b));
    });
  }

  List<Widget> _buildItems() {
    List<Widget> items = [];

    for (int index = 0; index < _items.length; index++) {
      var _item = _items[index];
      items.add(Dismissible(
        /// Each Dismissible must contain a Key. Keys allow Flutter to uniquely identify Widgets.
        key: Key(_item),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            setState(() {
              _items.removeAt(index);
              _items.add(_item);
            });
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Moved item $_item to bottom!',
              ),
              action: SnackBarAction(
                  label: 'UNDO',
                  textColor: Colors.amber,
                  onPressed: () {
                    setState(() {
                      _items.removeLast();
                      _items.insert(index, _item);
                    });
                  }),
            ));
          }
          if (direction == DismissDirection.endToStart) {
            setState(() {
              _items.removeAt(index);
            });
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Removed item $_item!',
              ),
              action: SnackBarAction(
                  label: 'UNDO',
                  textColor: Colors.amber,
                  onPressed: () {
                    setState(() {
                      _items.insert(index, _item);
                    });
                  }),
            ));
          }
        },
        background: Container(
          padding: const EdgeInsets.only(left: 12.0),
          alignment: Alignment.centerLeft,
          color: Colors.green,
          child: Icon(
            Icons.file_download,
            color: Colors.white,
          ),
        ),
        secondaryBackground: Container(
          padding: const EdgeInsets.only(right: 12.0),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: Icon(
            Icons.remove_circle,
            color: Colors.white,
          ),
        ),
        child: Card(
          child: InkWell(
            onTap: () {},
            splashColor: Colors.teal.withAlpha(50),
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text('$_item'),
            ),
          ),
        ),
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String item = await showSearch(context: context, delegate: CustomSearchDelegate(items: _items));
              if (item.isNotEmpty) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 300),
                    content: Text(
                      'You have searched $item',
                      style: TextStyle(color: Colors.amber),
                    )));
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: _reverseList,
          ),
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              _handleRefresh();
            },
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: NotificationListener<ScrollNotification>(
            /// Additional Auto Load on Scroll. To achieve this, we need to wrap our ListView.builder inside NotificationListener<ScrollNotification>
            onNotification: _handleScrollNotification,
            child: ReorderableListView(
              scrollDirection: Axis.vertical,
              onReorder: _onReorder,
              children: _buildItems(), // In ReorderableListView, each item must contain key
            ),
          ),
        ),
      ),
    );
  }

  /// Override AutomaticKeepAliveClientMixin combine with PageView to keep state alive
  @override
  bool get wantKeepAlive => true;
}

class SecondPage extends StatefulWidget {
  final List<String> originalItems;

  const SecondPage({Key key, this.originalItems}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with AutomaticKeepAliveClientMixin<SecondPage> {
  final _perPage = 10;
  int _present = 0;
  List<String> _items = [];
  bool _reverseSort = false;
  TextEditingController _editingController;
  ScrollController _controller;

  void loadMoreItems() {
    // if reach the last page
    if ((_present + _perPage) > widget.originalItems.length) {
      // add the rest items in original list
      _items.addAll(widget.originalItems.getRange(_present, widget.originalItems.length));
    } else {
      // add more items according to perPage
      _items.addAll(widget.originalItems.getRange(_present, _present + _perPage));
    }
    // increment present
    _present = _present + _perPage;
  }

  bool isLastItem() {
    return _present == widget.originalItems.length;
  }

  @override
  void initState() {
    super.initState();
    loadMoreItems();
    _editingController = TextEditingController();
    _controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _editingController.dispose();
    _controller.removeListener(_scrollListener);
    _controller.dispose();
  }

  void _scrollListener() {
    print('ON _scrollListener');
    if (_controller.position.extentAfter == 0 && !isLastItem()) {
      setState(() {
        loadMoreItems();
        print('ITEMS LENGTH: ${_items.length}');
      });
    }
  }

  Future<void> _handleRefresh() {
    /// mock refresh
    return Future<void>.delayed(Duration(milliseconds: 300), () {
      _items = [];
      _present = 0;
      loadMoreItems();
    }).then((_) {
      setState(() {});
      Scaffold.of(context)
          .showSnackBar(SnackBar(duration: Duration(milliseconds: 300), content: const Text('Refresh completed!')));
    });
  }

  void _filterSearch(String query) {
    final dummySearchList = [...widget.originalItems.getRange(0, _present)];
    if (query.isNotEmpty) {
      setState(() {
        _items = dummySearchList.where((item) => item.contains(query)).toList();
      });
    } else {
      setState(() {
        _items = widget.originalItems.getRange(0, _present).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: () {
              setState(() {
                _reverseSort = !_reverseSort;
                _items.sort((String a, String b) => _reverseSort ? b.compareTo(a) : a.compareTo(b));
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              _handleRefresh();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _editingController,
            decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))),
            onChanged: _filterSearch,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final _item = _items[index];
                    return Dismissible(
                      /// Each Dismissible must contain a Key. Keys allow Flutter to uniquely identify Widgets.
                      key: Key(_item),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          setState(() {
                            _items.removeAt(index);
                            _items.add(_item);
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Moved item $_item to bottom!',
                            ),
                            action: SnackBarAction(
                                label: 'UNDO',
                                textColor: Colors.amber,
                                onPressed: () {
                                  setState(() {
                                    _items.removeLast();
                                    _items.insert(index, _item);
                                  });
                                }),
                          ));
                        }
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            _items.removeAt(index);
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Removed item $_item!',
                            ),
                            action: SnackBarAction(
                                label: 'UNDO',
                                textColor: Colors.amber,
                                onPressed: () {
                                  setState(() {
                                    _items.insert(index, _item);
                                  });
                                }),
                          ));
                        }
                      },
                      background: Container(
                        padding: const EdgeInsets.only(left: 12.0),
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: Icon(
                          Icons.file_download,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.teal.withAlpha(50),
                          child: ListTile(
                            leading: Icon(Icons.book),
                            title: Text('$_item'),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  /// Override AutomaticKeepAliveClientMixin combine with PageView to keep state alive
  @override
  bool get wantKeepAlive => true;
}

class ThirdPage extends StatefulWidget {
  final List<String> originalItems;

  const ThirdPage({Key key, this.originalItems}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

/// Override AutomaticKeepAliveClientMixin to keep state alive
class _ThirdPageState extends State<ThirdPage> with AutomaticKeepAliveClientMixin<ThirdPage> {
  int perPage = 10;
  int present = 0;
  List<String> items = [];

  void loadMoreItems({@required List<String> originalItems}) {
    if (present < originalItems.length) {
      // if reach the last page
      if ((present + perPage) > originalItems.length) {
        // add the rest items in original list
        items.addAll(originalItems.getRange(present, originalItems.length));
      } else {
        // add more items according to perPage
        items.addAll(widget.originalItems.getRange(present, present + perPage));
      }
      // increment present
      present = present + perPage;
    }
  }

  @override
  void initState() {
    super.initState();

    /// Load first items at the very beginning
    loadMoreItems(originalItems: widget.originalItems);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),

          ///Here in the code itemCount if present i.e., no of items loaded is less than or equal to total no of items in original list then we return +1 so we can add LoadMore else we return the size of the list
          itemCount: (present < widget.originalItems.length) ? items.length + 1 : items.length,
          itemBuilder: (context, index) {
            return (index == items.length)

                /// Add 'Load More' Button at the end of the page.
                ? FlatButton(
                    child: const Text('Load More'),
                    onPressed: () {
                      setState(() {
                        loadMoreItems(originalItems: widget.originalItems);
                      });
                    },
                  )
                : Card(
                    child: InkWell(
                      onTap: () {},
                      splashColor: Colors.teal.withAlpha(50),
                      child: ListTile(
                        title: Text('${items[index]}'),
                      ),
                    ),
                  );
          }),
    );
  }

  /// Override AutomaticKeepAliveClientMixin combine with PageView to keep state alive
  @override
  bool get wantKeepAlive => true;
}
