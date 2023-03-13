import 'package:flutter/material.dart';

import '../component/MainNavPages.dart';
import '../component/contacts/ContactsList.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage();

  @override
  _ContactListPage createState() => _ContactListPage();
}

class _ContactListPage extends State<ContactListPage> {
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
