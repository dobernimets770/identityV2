import 'package:flutter/material.dart';

import '../component/MainNavPages.dart';
import '../component/contacts/ContactsList.dart';

class FavoritestListPage extends StatefulWidget {
  FavoritestListPage();

  @override
  _FavoritestListPage createState() => _FavoritestListPage();
}

class _FavoritestListPage extends State<FavoritestListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactList(
          initialItems: [
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 1',
            'Item 2',
            'Item 3',
          ],
          loadMoreItems: () async {
            // Load more items and return them as a list
            // List<String> moreItems = await myApi.loadMoreItems();
            return [];
          },
        ),
      ],
    );
  }
}
