import 'dart:async';

import 'package:flutter/material.dart';
import 'package:identity/Utils/contact_service.dart';
import 'package:identity/classes/contactManager.dart';
import '../Utils/fileManager.dart';
import '../component/contacts/ContactItem.dart';
import '../component/contacts/ContactViewGrid.dart';
import '../component/dialer/DialerButtons.dart';
import '../component/dialer/DialerSearch.dart';
import '../models/Contact.dart';

class DialerPage extends StatefulWidget {
  @override
  _DialerPageState createState() => _DialerPageState();
}

class _DialerPageState extends State<DialerPage> {
  Future<Map<String, dynamic>> getContacts = Future.value({});
  //Future<dynamic?> _localPath = Future.value();
  List<Contact> contactsSearch = [];
  Contact? findOneContact;
  Timer? timerDialButtonPress;
  bool? itsFirstTimeLoading = true;

  final controllerDialerSearch = TextEditingController();
  void initState() {
    super.initState();
    initContacts();
    // initTest();
    ;
  }

  initContacts() async {
    getContacts = ContactsService().getContacts(15);
  }

  // initTest() async {
  //   _localPath = FileManager().getLoclPath();
  // }

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

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              showContactsFindBySearchDialer(snapshot),
              Column(
                children: [
                  SearchInput(
                    clickBackSpaceInputDialer: clickBackSpaceInputDialer,
                    controllerDialerSearch: controllerDialerSearch,
                    onSearch: (query) {
                      // Handle search operation here
                    },
                  ),
                  Container(
                    child: DialerButtons(
                      clickDialerButton: clickDialerButton,
                    ),
                  ),
                ],
              )
            ],
          );
        }
      },
    );
  }

  clickBackSpaceInputDialer() {
    String currentText = controllerDialerSearch.text;
    if (currentText.length == 0) return;
    String newString = currentText.substring(0, currentText.length - 1);

    setState(() {
      controllerDialerSearch.text = newString;
    });
    onTimerDialSearchChange();
  }

  clickDialerButton(String value) {
    setState(() {
      controllerDialerSearch.text += value;
    });
    onTimerDialSearchChange();
  }

  clickItemContact(String value) {
    setState(() {
      controllerDialerSearch.text = value;
    });
  }

  searchDialInput() async {
    if (timerDialButtonPress?.isActive ?? true) {
      return;
    }
    if (controllerDialerSearch.text == "") {
      setState(() {
        contactsSearch = [];
      });
      findOneContact = null;
      return;
    }
    var result = await ContactsManager()
        .findContactsDevice(controllerDialerSearch.text, 15);
    findOneContact = null;
    if (result.length == 0) return;

    List<Contact> formatContact =
        await ContactsManager().formatContactFromSqlite(result);

    if (formatContact.length == 1) {
      findOneContact = formatContact[0];
    }
    setState(() {});
    List<String> phones = _getOnlyFhonesContacts(formatContact);
    //searchWhatsAppImage(phones);
  }

  Widget showContactsFindBySearchDialer(
      AsyncSnapshot<Map<String, dynamic>> snapshot) {
    if (contactsSearch.length == 0) {
      contactsSearch = snapshot.data!["contacts"] as List<Contact>;
    }

    List<String> phones = _getOnlyFhonesContacts(contactsSearch);
    addContactWhatsAppImage(phones);

    if (findOneContact != null) {
      return Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height *
                0.05), // set margin bottom to 20.0
        child: Container(
          height: 180,
          width: 130,
          child: ContactItem(
            localPath: snapshot.data!["localPath"],
            clickItemContact: clickItemContact,
            index: 2,
            contact: findOneContact!, //+972547702095
          ),
        ),
      );
      ;
    }

    return ContactViewGrid(
      localPath: snapshot.data!["localPath"],
      clickItemContact: clickItemContact,
      contactsItems: contactsSearch,
      itemPerRow: 5,
      heightGrid: MediaQuery.of(context).size.height * 0.3,
      widthGrid: MediaQuery.of(context).size.width * 0.8,
    );
  }

  onTimerDialSearchChange() {
    if (timerDialButtonPress?.isActive ?? false) timerDialButtonPress!.cancel();
    timerDialButtonPress = Timer(const Duration(milliseconds: 700), () {
      searchDialInput();
    });
  }

  addContactWhatsAppImage(List<String> phones) async {
    List<Map<String, Object>> listUpdatefilewhatsappImage = [];
    var contactsDevice = await getContacts;

    var contactServer =
        await ContactsManager().getWhatsAppImageContacts(phones);

    for (var conDevice in contactsDevice["contacts"]) {
      for (var conServer in contactServer) {
        String whatsappfileName = conServer["imgWhatsAppUrl"];
        String phoneContactServer = conServer["phone"];

        if (conDevice.uniquePhone == phoneContactServer) {
          String fileWhatsappName =
              await FileManager().saveWhatsappFile(whatsappfileName);
          conDevice.whatsappImg = fileWhatsappName;

          listUpdatefilewhatsappImage.add({
            "phone": conDevice.uniquePhone!,
            "whatsappFileName": fileWhatsappName
          });
          // change the phone number for this object
        }
      }
    }
    await ContactsManager()
        .updateSqliteContactWhatsappImage(listUpdatefilewhatsappImage);
    if (itsFirstTimeLoading == true) {
      itsFirstTimeLoading = false;
    }
    setState(() {
      contactsSearch = contactsSearch;
    });
  }

  _getOnlyFhonesContacts(List<Contact> contacts) {
    List<String> phones = contacts
        .where((contact) =>
            contact.whatsappImg == null &&
            contact.uniquePhone !=
                "") // filter out objects with null "user" property
        .map((obj) =>
            obj.uniquePhone!) // extract "phone" property from remaining objects
        .toList();
    return phones;
  }
}//5556106679
