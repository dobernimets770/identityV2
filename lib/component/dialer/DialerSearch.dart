import 'package:flutter/material.dart';

import '../../Utils/makeCall.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController controllerDialerSearch;
  final Function clickBackSpaceInputDialer;
  final FocusNode focusNode = FocusNode();
  SearchInput(
      {Key? key,
      required this.clickBackSpaceInputDialer,
      required this.onSearch,
      required this.controllerDialerSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  // function to execute when the container is tapped

                  makePhoneCall(controllerDialerSearch.text);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: controllerDialerSearch.text.length > 0
                          ? DecorationImage(
                              image: AssetImage('assets/Number.png'),
                              fit: BoxFit.cover,
                            )
                          : null),
                )),
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: controllerDialerSearch,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      clickBackSpaceInputDialer();
                    },
                    child: Container(
                      width: 50,
                      child: Icon(
                        Icons.backspace,
                        color: Color.fromARGB(255, 85, 83, 83),
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                ),
                onChanged: onSearch,
                style: TextStyle(fontSize: 33.0, fontWeight: FontWeight.w300),
                readOnly: true,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
