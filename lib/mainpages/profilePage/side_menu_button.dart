import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  late Color? icon_color;
  late Color? text_color;
  SideMenu(
      {Key? key,
      required this.icon,
      required this.text,
      this.icon_color,
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
            Icon(icon,
                size: 25,
                color: icon_color == null ? Colors.black : icon_color),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Quicksand',
                    color: text_color == null ? Colors.black : text_color),
              ),
            ),
          ],
        ));
  }
}
