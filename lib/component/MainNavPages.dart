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
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(
                  size: 30,
                  Icons.account_circle,
                  color: Color.fromARGB(255, 85, 83, 83),
                ),
                Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  size: 30,
                  Icons.account_box,
                  color: Color.fromARGB(255, 85, 83, 83),
                ),
                Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  size: 30,
                  Icons.star,
                  color: Color.fromARGB(255, 85, 83, 83),
                ),
                Text(
                  "Favorites",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  size: 30,
                  Icons.phone,
                  color: Color.fromARGB(255, 85, 83, 83),
                ),
                Text(
                  "Resent",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
