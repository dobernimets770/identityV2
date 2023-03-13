import 'package:flutter/material.dart';
import 'Button.dart';

const buttonCharacters = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "*",
  "0",
  "#"
];

class DialerButtons extends StatelessWidget {
  final Function clickDialerButton;
  const DialerButtons({
    Key? key,
    required this.clickDialerButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.43,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_createButtonLayout(context)]),
    );
    // Empty container for now
  }

  Widget _createButtonLayout(BuildContext context) {
    List<Widget> rows = [];

    for (int i = 0; i < buttonCharacters.length; i += 3) {
      List<Widget> rowChildren = [];

      for (int j = i; j < i + 3 && j < buttonCharacters.length; j++) {
        rowChildren.add(Button(
          onPressed: clickDialerButton,
          character: buttonCharacters[j],
        ));
      }

      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowChildren,
      ));

      rows.add(SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ));
    }

    return Column(
      children: rows,
    );
  }
}
