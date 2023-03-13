import 'package:identity/Store/sqldb.dart';
import 'dart:convert';
import '../models/Contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ContactsManager {
  findContactsDevice(String searchText, int limit) async {
    String query =
        "SELECT * FROM Contact WHERE uniquePhone LIKE '%$searchText%' LIMIT $limit";
    SqlDb sqlDb = await SqlDb();
    var listContact = await sqlDb.readData(query);
    return listContact; //
  }

  formatContactFromSqlite(List<dynamic> list) {
    dynamic fixContact = list.map((m) {
      Map<dynamic, dynamic> obJContact = {};
      obJContact["displayName"] = m["displayName"];
      obJContact["postalAddresses"] = obJContact["postalAddresses"] == null
          ? []
          : jsonDecode(m["postalAddresses"]);
      obJContact["phones"] = m["phones"] == null ? [] : jsonDecode(m["phones"]);
      obJContact["givenName"] = m["givenName"];
      obJContact["emails"] = m["emails"] == null ? [] : jsonDecode(m["emails"]);
      obJContact["middleName"] = m["middleName"];
      obJContact["prefix"] = m["prefix"];
      obJContact["suffix"] = m["suffix"];
      obJContact["familyName"] = m["familyName"];
      obJContact["company"] = m["company"];
      obJContact["jobTitle"] = m["jobTitle"];
      obJContact["androidAccountType"] = m["androidAccountType"];
      obJContact["avatar"] = m["avatar"];
      obJContact["birthday"] = m["birthday"];
      obJContact["androidAccountTypeRaw"] = m["androidAccountTypeRaw"];
      obJContact["androidAccountName"] = m["androidAccountName"];
      obJContact["identifier"] = m["identifier"];
      obJContact["permissionGroupId"] = m["permissionGroupId"];
      obJContact["uniquePhone"] = m["uniquePhone"];
      obJContact["whatsappImg"] = m["whatsappImg"];

      return Contact.fromMap(obJContact);
    }).toList();
    return fixContact as List<Contact>;
  }

  getWhatsAppImageContacts(List<String> contactsPhone) async {
    var headers = {
      // 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('http://162.55.83.103:8800/api/contacts/findContactDetails'));
    request.body = json.encode(contactsPhone);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var string = await response.stream.bytesToString();
      var contacts = json.decode(string);
      return contacts;
    } else {
      print(response.reasonPhrase);
    }
  }

  getSomeContacts(int limit) async {
    String query = "SELECT * FROM Contact  LIMIT $limit";
    SqlDb sqlDb = await SqlDb();
    var listContact = await sqlDb.readData(query);
    return listContact;
  }

  createContactToStoreDevice(dynamic contat) async {
    SqlDb sqlDb = await SqlDb();
    List<dynamic> param = [
      contat["displayName"],
      contat["postalAddresses"],
      contat["phones"],
      contat["givenName"],
      contat["emails"],
      contat["middleName"],
      contat["prefix"],
      contat["suffix"],
      contat["familyName"],
      contat["company"],
      contat["jobTitle"],
      contat["androidAccountType"],
      contat["avatar"],
      contat['birthday'],
      contat['androidAccountTypeRaw'],
      contat["androidAccountName"],
      contat['identifier'],
      contat["permissionGroupId"],
      contat['uniquePhone'],
      contat['whatsappImg']
    ];
    try {
      await sqlDb.insertData(
          "INSERT INTO Contact VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
          param);
    } catch (err) {
      print(err);
    }
  }

  updateSqliteContactWhatsappImage(List<dynamic> contactsPhone) async {
    SqlDb sqlDb = await SqlDb();

    List<Future> futures = [];

    for (var item in contactsPhone) {
      if (item['whatsappFileName'] != null) {
        var whatsappFileName = item['whatsappFileName'];

        var phone = item['phone'];
        futures.add(sqlDb.updateData(
            "UPDATE Contact SET whatsappImg = '$whatsappFileName' WHERE uniquePhone = '$phone'"));
      }
    }
    await Future.wait(futures);
  }
}
