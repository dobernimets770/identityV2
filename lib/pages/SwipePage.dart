import 'package:flutter/material.dart';
import 'package:identity/pages/ContactsListPage.dart';
import 'package:identity/pages/FavoritestListPage.dart';
import 'package:identity/pages/DialerPage.dart';

import '../component/MainNavPages.dart';

void main() => runApp(const SwipePage());

class SwipePage extends StatelessWidget {
  const SwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: PageViewDemo(),
        ));
  }
}

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({super.key});

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              PageView(
                controller: _controller,
                children: [
                  DialerPage(),
                  ContactsListPage(),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.89),
                      ],
                      stops: [0, 0.9227],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        MainNavPages(),
      ],
    );
    ;
  }
}
