import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  List<String> initialItems;
  Function loadMoreItems;

  ContactList({required this.initialItems, required this.loadMoreItems});

  @override
  _ContactList createState() => _ContactList();
}

class _ContactList extends State<ContactList> {
  ScrollController _scrollController = ScrollController();
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //    List<String> moreItems = widget.loadMoreItems();
      setState(() {
        _items.add("test");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(_items[index]));
        },
      ),
    );
  }
}
