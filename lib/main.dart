// import 'package:flutter/material.dart';
// import 'package:identity/pages/ContactsPageList.dart';
// import 'package:identity/pages/DialerPage.dart';
// import 'component/MainNavPages.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           body: PageViewDemo(),
//         ));
//   }
// }

// class PageViewDemo extends StatefulWidget {
//   const PageViewDemo({super.key});

//   @override
//   State<PageViewDemo> createState() => _PageViewDemoState();
// }

// class _PageViewDemoState extends State<PageViewDemo> {
//   final _controller = PageController(
//     initialPage: 0,
//   );

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Expanded(
//           child: PageView(controller: _controller, children: [
//             DialerPage(),
//             ContactListPage(),
//           ]),
//         ),
//         MainNavPages(),
//       ],
//     );
//   }
// }

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
