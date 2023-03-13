import 'package:flutter/material.dart';

Map<String, String> buttonsTextMap = {
  "1": '',
  "2": 'ABC',
  "3": 'DEF',
  "4": 'GHI',
  "5": 'JKL',
  "6": 'MNO',
  "7": 'PQRS',
  "8": 'TUV',
  "9": 'WXYZ',
  "*": '',
  "0": '+',
  "#": '',
};

class Button extends StatelessWidget {
  final String character;
  final Function onPressed;

  const Button({Key? key, required this.character, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(character);
      },
      onLongPress: () {
        if (character == "0") {
          onPressed("+");
        }
      },
      child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 223, 223, 223),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: _createButton(character)),
    );
  }

  Widget _createButton(String keyButtonText) {
    var buttonsText = buttonsTextMap[keyButtonText];
    if (buttonsText == "" && keyButtonText != "0" && keyButtonText != "1") {
      return Center(
        child: Text(
          keyButtonText,
          style: TextStyle(fontSize: 35.0),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            keyButtonText,
            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w100),
          ),
          Text(
            buttonsText!,
            style: TextStyle(fontSize: 13.0),
          ),
        ],
      );
    }
  }
}
