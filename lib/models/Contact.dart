import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:quiver/core.dart';




class FormOperationException implements Exception {
  final FormOperationErrorCode? errorCode;

  const FormOperationException({this.errorCode});
  String toString() => 'FormOperationException: $errorCode';
}

enum FormOperationErrorCode {
  FORM_OPERATION_CANCELED,
  FORM_COULD_NOT_BE_OPEN,
  FORM_OPERATION_UNKNOWN_ERROR
}

class Contact {
  Contact(
      {this.identifier,
      this.displayName,
      this.givenName,
      this.middleName,
      this.prefix,
      this.suffix,
      this.familyName,
      this.company,
      this.jobTitle,
      this.emails,
      this.phones,
      this.postalAddresses,
      this.avatar,
      this.birthday,
      this.androidAccountType,
      this.androidAccountTypeRaw,
      this.androidAccountName,
      this.permissionGroupId,
      this.whatsappImg,
      this.uniquePhone});

  String? identifier,
      displayName,
      givenName,
      middleName,
      prefix,
      suffix,
      familyName,
      company,
      jobTitle,
      permissionGroupId,
      whatsappImg,
      uniquePhone;
  String? androidAccountTypeRaw, androidAccountName;
  AndroidAccountType? androidAccountType;
  List<Item>? emails = [];
  List<Item>? phones = [];
  List<PostalAddress>? postalAddresses = [];
  Uint8List? avatar;
  DateTime? birthday;

  String initials() {
    return ((this.givenName?.isNotEmpty == true ? this.givenName![0] : "") +
            (this.familyName?.isNotEmpty == true ? this.familyName![0] : ""))
        .toUpperCase();
  }

  Contact.fromMap(Map m) {
    identifier = m["identifier"];
    displayName = m["displayName"];
    givenName = m["givenName"];
    middleName = m["middleName"];
    familyName = m["familyName"];
    whatsappImg = m["whatsappImg"];
    permissionGroupId = m["permissionGroupId"];
    prefix = m["prefix"];
    suffix = m["suffix"];
    company = m["company"];
    jobTitle = m["jobTitle"];
    uniquePhone = m["uniquePhone"];
    androidAccountTypeRaw = m["androidAccountType"];
    androidAccountType = accountTypeFromString(androidAccountTypeRaw);
    androidAccountName = m["androidAccountName"];
    emails = (m["emails"] as List?)?.map((m) => Item.fromMap(m)).toList();
    phones = (m["phones"] as List?)?.map((m) => Item.fromMap(m)).toList();
    postalAddresses = (m["postalAddresses"] as List?)
        ?.map((m) => PostalAddress.fromMap(m))
        .toList();
    try {
      avatar = m["avatar"];
    } catch (error) {
      List<dynamic> a = m["avatar"];
      List<int> intList = a.cast<int>().toList();
      Uint8List b = Uint8List.fromList(intList);
      avatar = b;
      print(error.toString());
    }

    try {
      birthday = m["birthday"] != null ? DateTime.parse(m["birthday"]) : null;
    } catch (e) {
      birthday = null;
    }
  }

  static Map _toMap(Contact contact) {
    var emails = [];
    for (Item email in contact.emails ?? []) {
      emails.add(Item._toMap(email));
    }
    var phones = [];
    for (Item phone in contact.phones ?? []) {
      phones.add(Item._toMap(phone));
    }
    var postalAddresses = [];
    for (PostalAddress address in contact.postalAddresses ?? []) {
      postalAddresses.add(PostalAddress._toMap(address));
    }

    final birthday = contact.birthday == null
        ? null
        : "${contact.birthday!.year.toString()}-${contact.birthday!.month.toString().padLeft(2, '0')}-${contact.birthday!.day.toString().padLeft(2, '0')}";

    return {
      "uniquePhone": contact.uniquePhone,
      "identifier": contact.identifier,
      "displayName": contact.displayName,
      "givenName": contact.givenName,
      "middleName": contact.middleName,
      "familyName": contact.familyName,
      "prefix": contact.prefix,
      "suffix": contact.suffix,
      "company": contact.company,
      "jobTitle": contact.jobTitle,
      "androidAccountType": contact.androidAccountTypeRaw,
      "androidAccountName": contact.androidAccountName,
      "emails": emails,
      "phones": phones,
      "postalAddresses": postalAddresses,
      //   "avatar": contact.avatar != null ? base64.encode(contact.avatar ?? Uint8List(0)) : null,
      "avatar": contact.avatar,
      "birthday": birthday
    };
  }

  Map toMap() {
    return Contact._toMap(this);
  }

  /// The [+] operator fills in this contact's empty fields with the fields from [other]
  operator +(Contact other) => Contact(
        givenName: this.givenName ?? other.givenName,
        middleName: this.middleName ?? other.middleName,
        prefix: this.prefix ?? other.prefix,
        suffix: this.suffix ?? other.suffix,
        familyName: this.familyName ?? other.familyName,
        company: this.company ?? other.company,
        jobTitle: this.jobTitle ?? other.jobTitle,
        androidAccountType: this.androidAccountType ?? other.androidAccountType,
        androidAccountName: this.androidAccountName ?? other.androidAccountName,
        emails: this.emails == null
            ? other.emails
            : this
                .emails!
                .toSet()
                .union(other.emails?.toSet() ?? Set())
                .toList(),
        phones: this.phones == null
            ? other.phones
            : this
                .phones!
                .toSet()
                .union(other.phones?.toSet() ?? Set())
                .toList(),
        postalAddresses: this.postalAddresses == null
            ? other.postalAddresses
            : this
                .postalAddresses!
                .toSet()
                .union(other.postalAddresses?.toSet() ?? Set())
                .toList(),
        avatar: this.avatar ?? other.avatar,
        birthday: this.birthday ?? other.birthday,
      );

  /// Returns true if all items in this contact are identical.
  @override
  bool operator ==(Object other) {
    return other is Contact &&
        this.avatar == other.avatar &&
        this.company == other.company &&
        this.displayName == other.displayName &&
        this.givenName == other.givenName &&
        this.familyName == other.familyName &&
        this.identifier == other.identifier &&
        this.jobTitle == other.jobTitle &&
        this.androidAccountType == other.androidAccountType &&
        this.androidAccountName == other.androidAccountName &&
        this.middleName == other.middleName &&
        this.prefix == other.prefix &&
        this.suffix == other.suffix &&
        this.birthday == other.birthday &&
        DeepCollectionEquality.unordered().equals(this.phones, other.phones) &&
        DeepCollectionEquality.unordered().equals(this.emails, other.emails) &&
        DeepCollectionEquality.unordered()
            .equals(this.postalAddresses, other.postalAddresses);
  }

  @override
  int get hashCode {
    return hashObjects([
      this.company,
      this.displayName,
      this.familyName,
      this.givenName,
      this.identifier,
      this.jobTitle,
      this.androidAccountType,
      this.androidAccountName,
      this.middleName,
      this.prefix,
      this.suffix,
      this.birthday,
    ].where((s) => s != null));
  }

  AndroidAccountType? accountTypeFromString(String? androidAccountType) {
    if (androidAccountType == null) {
      return null;
    }
    if (androidAccountType.startsWith("com.google")) {
      return AndroidAccountType.google;
    } else if (androidAccountType.startsWith("com.whatsapp")) {
      return AndroidAccountType.whatsapp;
    } else if (androidAccountType.startsWith("com.facebook")) {
      return AndroidAccountType.facebook;
    }

    /// Other account types are not supported on Android
    /// such as Samsung, htc etc...
    return AndroidAccountType.other;
  }
}

class PostalAddress {
  PostalAddress(
      {this.label,
      this.street,
      this.city,
      this.postcode,
      this.region,
      this.country});
  String? label, street, city, postcode, region, country;

  PostalAddress.fromMap(Map m) {
    label = m["label"];
    street = m["street"];
    city = m["city"];
    postcode = m["postcode"];
    region = m["region"];
    country = m["country"];
  }

  @override
  bool operator ==(Object other) {
    return other is PostalAddress &&
        this.city == other.city &&
        this.country == other.country &&
        this.label == other.label &&
        this.postcode == other.postcode &&
        this.region == other.region &&
        this.street == other.street;
  }

  @override
  int get hashCode {
    return hashObjects([
      this.label,
      this.street,
      this.city,
      this.country,
      this.region,
      this.postcode,
    ].where((s) => s != null));
  }

  static Map _toMap(PostalAddress address) => {
        "label": address.label,
        "street": address.street,
        "city": address.city,
        "postcode": address.postcode,
        "region": address.region,
        "country": address.country
      };

  @override
  String toString() {
    String finalString = "";
    if (this.street != null) {
      finalString += this.street!;
    }
    if (this.city != null) {
      if (finalString.isNotEmpty) {
        finalString += ", " + this.city!;
      } else {
        finalString += this.city!;
      }
    }
    if (this.region != null) {
      if (finalString.isNotEmpty) {
        finalString += ", " + this.region!;
      } else {
        finalString += this.region!;
      }
    }
    if (this.postcode != null) {
      if (finalString.isNotEmpty) {
        finalString += " " + this.postcode!;
      } else {
        finalString += this.postcode!;
      }
    }
    if (this.country != null) {
      if (finalString.isNotEmpty) {
        finalString += ", " + this.country!;
      } else {
        finalString += this.country!;
      }
    }
    return finalString;
  }
}

/// Item class used for contact fields which only have a [label] and
/// a [value], such as emails and phone numbers
class Item {
  Item({this.label, this.value});

  String? label, value;

  Item.fromMap(Map m) {
    label = m["label"];
    value = m["value"];
  }

  @override
  bool operator ==(Object other) {
    return other is Item &&
        this.label == other.label &&
        this.value == other.value;
  }

  @override
  int get hashCode => hash2(label ?? "", value ?? "");

  static Map _toMap(Item i) => {"label": i.label, "value": i.value};
}

enum AndroidAccountType { facebook, google, whatsapp, other }