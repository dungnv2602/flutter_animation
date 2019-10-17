import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> items;

  CustomSearchDelegate({this.items});
  /// build list action widgets
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // 'query' is the query on search bar
          showSuggestions(context);
        },
      )
    ];
  }
  /// build leading icon
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = items.where((item) => item.toLowerCase().contains(query.toLowerCase()));

    return results.isEmpty
        ? Center(child: const Text('No data!'))
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results.elementAt(index);
              return Card(
                child: InkWell(
                  onTap: () {
                    close(context, item);
                  },
                  splashColor: Colors.teal.withAlpha(50),
                  child: ListTile(
                    leading: Icon(Icons.book),
                    title: Text(
                      item,
                      style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 16.0),
                    ),
                  ),
                ),
              );
            });
  }

  /// This method is called everytime the search term changes.
  /// If you want to add search suggestions as the user enters their search term, this is the place to do that.
  @override
  Widget buildSuggestions(BuildContext context) {
    final results = items.where((item) => item.toLowerCase().contains(query.toLowerCase()));

    return results.isEmpty
        ? Center(child: const Text('No data!', style: TextStyle(color: Colors.blue)))
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results.elementAt(index);
              return ListTile(
                onTap: () {
                  close(context, item);
                },
                title: Text(
                  item,
                  style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 16.0, color: Colors.blue),
                ),
              );
            });
  }
}
