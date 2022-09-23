import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class show_date extends StatelessWidget {
  const show_date({
    Key? key,
    required this.event,
    this.showIcon,
  }) : super(key: key);

  final Event event;
  final bool? showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(-1.035, 0),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
      //alignment: Alignment.,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 2.3,
        children: [
          showIcon == null ? withOutIcon(event) : withIcon(event),
        ],
      ),
    );
  }
}

withOutIcon(Event event) {
  return Text(
    DateFormat('MMMM dd, yyyy @ h:mm a').format(event.time),
    style: const TextStyle(
        fontFamily: 'Quicksand',
        color: Colors.orange,
        fontWeight: FontWeight.w500,
        fontSize: 16),
  );
}

withIcon(Event event) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(
        Icons.calendar_today_rounded,
        size: 32,
        color: Colors.red,
      ),
      const SizedBox(width: 8),
      Text(
        DateFormat('MMMM dd, yyyy @ h:mm a').format(event.time),
        style: const TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 18),
      ),
    ],
  );
}
