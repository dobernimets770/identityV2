import 'package:flutter/material.dart';

import '../../Utils/fileManager.dart';
import '../../models/Contact.dart';

class ContactItem extends StatefulWidget {
  final int index;
  final Contact contact;
  final String? localPath;
  final Function? clickItemContact;
  const ContactItem(
      {super.key,
      required this.index,
      this.localPath,
      required this.contact,
      this.clickItemContact});

  @override
  State<ContactItem> createState() => _ContactItemState();
}

late String _localPath;

class _ContactItemState extends State<ContactItem>
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
    return InkWell(
        onTap: () {
          if (widget.clickItemContact != null) {
            widget.clickItemContact!(widget.contact.uniquePhone);
          }
          // Handle the click event here
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: showContactImage(),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0, 0.6, 1],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 5),
                          Flexible(
                            child: Text(widget.contact.displayName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 10.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  showContactImage() {
    String? whatsappImg = widget.contact.whatsappImg;
    if (whatsappImg == null) {
      return DecorationImage(
        image: AssetImage("assets/person-placeholder.jpeg"),
        fit: BoxFit.cover,
      );
    } else {
      return DecorationImage(
        image: AssetImage(widget.localPath! + "/$whatsappImg"),
        fit: BoxFit.cover,
      );
    }
  }
}
