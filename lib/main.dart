import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:identity/pages/GetContactsPermissionsPageState.dart';
import 'package:identity/pages/SwipePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IdentityNavigator(),
      routes: <String, WidgetBuilder>{
        '/SwipePage': (BuildContext context) => SwipePage(),
        '/GetContactsPermissionsPageState': (BuildContext context) =>
            GetContactsPermissionsPageState(),
      },
    );
  }
}

class IdentityNavigator extends StatefulWidget {
  @override
  _IdentityNavigatorState createState() => _IdentityNavigatorState();
}

class _IdentityNavigatorState extends State<IdentityNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        builder: (BuildContext context, AsyncSnapshot<dynamic?> snapshot) {
      return GetContactsPermissionsPageState();
    });
  }
}
