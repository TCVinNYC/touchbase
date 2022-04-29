import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:intl/intl.dart';

class showOtherDetails extends StatelessWidget {
  const showOtherDetails({
    Key? key,
    required this.text,
    this.showIcon, this.icon, required this.color,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final bool? showIcon;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(-1.035, 0),
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 3),
      //alignment: Alignment.,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 2.3,
        children: [
          showIcon == false ? withOutIcon(text, color) : withIcon(text, icon ??  Icons.abc_outlined, color),
        ],
      ),
    );
  }
}

withOutIcon(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: 'Quicksand',
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16),
  );
}

withIcon(String text, IconData icon, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        size: 28,
        color: color,
      ),
     // icon,
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
            fontFamily: 'Quicksand',
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
    ],
  );
}
