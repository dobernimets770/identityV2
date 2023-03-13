import 'dart:async';
import 'package:flutter/services.dart';
import 'package:identity/Utils/addRegionCode.dart';
import 'package:identity/Utils/fileManager.dart';
import 'package:identity/models/Contact.dart';
import 'dart:convert';
import 'dart:math';
import '../Store/sqldb.dart';
import '../classes/contactManager.dart';

var myMapContact = {};

class ContactsService {
  static const MethodChannel _channel =
      MethodChannel('github.com/clovisnicolas/flutter_contacts');

  /// matching [query]
  Future<Map<String, dynamic>> getContacts(int count,
      {String? query,
      bool withThumbnails = true,
      bool photoHighResolution = true,
      bool orderByGivenName = true,
      bool iOSLocalizedLabels = true,
      bool androidLocalizedLabels = true}) async {
    SqlDb sqlDb = await SqlDb();
    // List<Contact> fixContact = [];
    List<Map<dynamic, dynamic>> contactsCreateServer = [];
    List<Map> list = await sqlDb.readData('SELECT * FROM Contact');
    if (list.length == 0) {
      Iterable contacts =
          await _channel.invokeMethod('getContacts', <String, dynamic>{
        'query': query,
        'withThumbnails': withThumbnails,
        'photoHighResolution': photoHighResolution,
        'orderByGivenName': orderByGivenName,
        'iOSLocalizedLabels': iOSLocalizedLabels,
        'androidLocalizedLabels': androidLocalizedLabels,
      });
      List<dynamic> ic = [];

      for (var contact in contacts) {
        await createContactDevice(contact);
      }

      //ContactsManager().createContacts(contactsCreateServer);
    }

    var conttactFromSqlite = await ContactsManager().getSomeContacts(30);
    var fixCon =
        await ContactsManager().formatContactFromSqlite(conttactFromSqlite);
    var localPath = await FileManager().getLoclPath();
    return {'contacts': fixCon, "localPath": localPath};
  }

  formatContactFromForamtContactDevice(dynamic contact) async {
    String? permissionGroupId;

    if (contact["phones"].length > 0) {
      String? phone = contact["phones"][0]["value"];
      dynamic findContact = myMapContact[phone];
      if (findContact != null) {
        permissionGroupId = findContact["permissionGroupId"];
      } else {
        permissionGroupId = "Other";
      }
    }
    final random = Random();
    final number = random.nextInt(4);

    String? uniquePhone = "";
    var whatsappImg = null;
    if (contact["phones"].length > 0) {
      uniquePhone = await addRegionCode(contact["phones"][0]["value"]!);
    }
    final contactInfo = {
      "permissionGroupId": ["A", "B", "C", "Other"][random.nextInt(4)],
      "displayName": contact["displayName"],
      "postalAddresses": jsonEncode(contact["postalAddresses"]),
      "phones": jsonEncode(contact["phones"]),
      "givenName": contact["givenName"],
      "emails": jsonEncode(contact["emails"]),
      "middleName": contact["middleName"],
      "prefix": contact["prefix"],
      "suffix": contact["suffix"],
      'familyName': contact["familyName"],
      "company": contact["company"],
      "jobTitle": contact["jobTitle"],
      "androidAccountType": contact["androidAccountType"],
      "avatar": contact["avatar"],
      "birthday": contact["birthday"],
      "androidAccountTypeRaw": contact["androidAccountTypeRaw"],
      "androidAccountName": contact["androidAccountName"],
      "identifier": contact["identifier"],
      "uniquePhone": uniquePhone,
      "whatsappImg": null
    };

    return contactInfo;
  }

  createContactDevice(dynamic contact) async {
    var result = await formatContactFromForamtContactDevice(contact);
    await ContactsManager().createContactToStoreDevice(result);

    contact["permissionGroupId"] = result["permissionGroupId"];
    contact["uniquePhone"] = result["uniquePhone"];
    Map<dynamic, dynamic> contactCreateServ = {};
    //String cleanPhone = uniquePhone!.replaceAll(RegExp(r'[^\d+]'), "");
    if (result["uniquePhone"] != "") {
      contactCreateServ["permissionGroupId"] = result["permissionGroupId"];
      contactCreateServ["phone"] = result["uniquePhone"];
      //contactsCreateServer.add(contactCreateServ);
    }
  }
}
