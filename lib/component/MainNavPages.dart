import 'package:flutter/material.dart';

class MainNavPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 233, 233, 233),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              size: 30,
              Icons.account_circle,
              color: Color.fromARGB(255, 85, 83, 83),
            ),
            Icon(
              size: 30,
              Icons.account_box,
              color: Color.fromARGB(255, 85, 83, 83),
            ),
            Icon(
              size: 30,
              Icons.star,
              color: Color.fromARGB(255, 85, 83, 83),
            ),
            Icon(
              size: 30,
              Icons.phone,
              color: Color.fromARGB(255, 85, 83, 83),
            ),
          ],
        ),
      ),
    );
  }
}
