import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SideMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  // ignore: non_constant_identifier_names
  late Color? icon_color;
  // ignore: non_constant_identifier_names
  late Color? text_color;
  SideMenu(
      {Key? key,
      required this.icon,
      required this.text,
      // ignore: non_constant_identifier_names
      this.icon_color,
      // ignore: non_constant_identifier_names
      this.text_color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 25, color: icon_color ?? Colors.black),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Quicksand',
                    color: text_color ?? Colors.black),
              ),
            ),
          ],
        ));
  }
}
