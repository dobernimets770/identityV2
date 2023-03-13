import 'package:flutter/material.dart';

class HeaderContact extends StatefulWidget {
  final TextEditingController controllerContactSearch;
  final void Function(String?) onSearch;
  const HeaderContact(
      {super.key,
      required this.controllerContactSearch,
      required this.onSearch});

  @override
  State<HeaderContact> createState() => _HeaderContact();
}

class _HeaderContact extends State<HeaderContact>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
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
      width: MediaQuery.of(context).size.width * 0.87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Row(
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
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 234, 233, 233),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: widget.controllerContactSearch,
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                hintText: "Search Contacts",
                hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 190, 189, 189)),
                prefixIcon: GestureDetector(
                  child: Container(
                    width: 50,
                    child: Icon(
                      Icons.search,
                      size: 37,
                      color: Color.fromARGB(255, 85, 83, 83),
                    ),
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              ),
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
