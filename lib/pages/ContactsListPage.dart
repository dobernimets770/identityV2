import 'package:flutter/material.dart';

import '../Utils/contact_service.dart';
import '../classes/contactManager.dart';
import '../component/contacts/ContactViewGrid.dart';
import '../models/Contact.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPage();
}

class _ContactsListPage extends State<ContactsListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Future<Map<String, dynamic>> getContacts = Future.value({});
  bool itsFirstLoiad = true;
  List<Contact> contactsSearch = [];
  @override
  void initState() {
    super.initState();
    initContacts();
    _controller = AnimationController(vsync: this);
  }

  initContacts() async {
    getContacts = ContactsService().getContacts(20);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getContacts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Visibility(
            visible: false,
            child: CircularProgressIndicator(),
          ); // Show a loading spinner while we're waiting for the contacts to be fetched
        } else {
          // Set the contactsItems to an empty list if there was an error fetching the contacts
          return showContactsFindBySearch(snapshot);
        }
      },
    );
  }

  Widget showContactsFindBySearch(
      AsyncSnapshot<Map<String, dynamic>> snapshot) {
    if (contactsSearch.length ==
        0 /*and searc input that for init upload componenet*/) {
      contactsSearch = snapshot.data!["contacts"] as List<Contact>;
    }

    List<String> phones =
        ContactsManager().getOnlyFhonesContacts(contactsSearch);
    addContactWhatsAppImage(phones);

    return ContactViewGrid(
      localPath: snapshot.data!["localPath"],
      clickItemContact: () {},
      contactsItems: contactsSearch,
      itemPerRow: 4,
      heightGrid: MediaQuery.of(context).size.height * 0.3,
      widthGrid: MediaQuery.of(context).size.width * 0.8,
    );
  }

  addContactWhatsAppImage(List<String> phones) async {
    await ContactsManager().addContactWhatsAppImage(phones, getContacts);
    setState(() {
      contactsSearch = contactsSearch;
    });
  }
}
