import 'package:flutter/material.dart';

import '../../models/Contact.dart';
import 'ContactItem.dart';

class ContactViewGrid extends StatefulWidget {
  final int itemPerRow;
  final double widthGrid;
  final double heightGrid;
  final List<Contact> contactsItems;
  final Function? clickItemContact;
  final String? localPath;
  const ContactViewGrid(
      {super.key,
      required this.widthGrid,
      this.localPath,
      required this.contactsItems,
      required this.heightGrid,
      this.clickItemContact,
      required this.itemPerRow});

  @override
  State<ContactViewGrid> createState() => _ContactViewGridState();
}

class _ContactViewGridState extends State<ContactViewGrid>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthGrid,
      // color: Color.fromARGB(255, 33, 243, 103),
      height: widget.heightGrid,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: widget.contactsItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.itemPerRow,
          crossAxisSpacing: widget.widthGrid * 0.04,
          mainAxisSpacing: widget.widthGrid * 0.04,
          childAspectRatio: 1 / 1.34,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ContactItem(
            localPath: widget.localPath,
            clickItemContact: widget.clickItemContact,
            index: index,
            contact: widget.contactsItems[index],
          );
        },
      ),
    );
  }
}
