import 'package:flutter/material.dart';

class HeaderContact extends StatefulWidget {
  const HeaderContact({super.key});

  @override
  State<HeaderContact> createState() => _HeaderContact();
}

class _HeaderContact extends State<HeaderContact>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 191, 216, 236),
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.86,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    'Contacts',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 85, 83, 83)),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        'Select',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 85, 83, 83)),
                      ),
                    ),
                    Icon(
                      size: 28,
                      Icons.add,
                      color: Color.fromARGB(255, 85, 83, 83),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //Container(child: ,)
        ],
      ),
    );
  }
}
