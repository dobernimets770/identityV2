import 'dart:async';

import 'package:flutter/material.dart';

import '../Utils/contact_service.dart';
import '../classes/contactManager.dart';
import '../component/contacts/ContactViewGrid.dart';
import '../component/contacts/HeaderContact.dart';
import '../models/Contact.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPage();
}

class _ContactsListPage extends State<ContactsListPage>
    with SingleTickerProviderStateMixin {
  Timer? timerContactSearch;

  late AnimationController _controller;
  final TextEditingController controllerContactSearch = TextEditingController();

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
    getContacts = ContactsService().getContacts(25);
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
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  HeaderContact(
                    onSearch: onSearch,
                    controllerContactSearch: controllerContactSearch,
                  ),
                ],
              ),
              showContactsFindBySearch(snapshot),
            ],
          );
        }
      },
    );
  }

  Widget showContactsFindBySearch(
      AsyncSnapshot<Map<String, dynamic>> snapshot) {
    if (contactsSearch.length == 0 &&
        controllerContactSearch.text.length ==
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
      heightGrid: MediaQuery.of(context).size.height * 0.7,
      widthGrid: MediaQuery.of(context).size.width * 0.92,
    );
  }

  addContactWhatsAppImage(List<String> phones) async {
    await ContactsManager().addContactWhatsAppImage(phones, getContacts);
    setState(() {
      contactsSearch = contactsSearch;
    });
  }

  void onSearch(String? value) {
    onTimerContacsSearchChange();
  }

  onTimerContacsSearchChange() {
    if (timerContactSearch?.isActive ?? false) timerContactSearch!.cancel();
    timerContactSearch = Timer(const Duration(milliseconds: 700), () {
      searchContactsInput();
    });
  }

  searchContactsInput() async {
    if (timerContactSearch?.isActive ?? true) {
      return;
    }
    if (controllerContactSearch.text == "") {
      setState(() async {
        var contacsFuture = await getContacts as dynamic;
        setState(() {
          contactsSearch = contacsFuture["contacts"] as List<Contact>;
        });
      });
      return;
    }
    var result = await ContactsManager()
        .findContactsDeviceByNameAndPhone(controllerContactSearch.text, 15);

    if (result.length == 0) {
      setState(() {
        contactsSearch = [];
      });
    }
    ;

    //}

    List<Contact> formatContact =
        await ContactsManager().formatContactFromSqlite(result);

    List<String> phones =
        ContactsManager().getOnlyFhonesContacts(formatContact);
    await addContactWhatsAppImage(phones);
    setState(() {
      contactsSearch = formatContact;
    });
  }
}
