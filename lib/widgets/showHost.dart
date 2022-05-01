import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';

class showHost extends StatelessWidget {
  const showHost({
    Key? key,
    required this.event,
    this.showName,
  }) : super(key: key);

  final Event event;
  final bool? showName;

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
          showName == null ? withOutIcon(event) : withIcon(event),
        ],
      ),
    );
  }
}

withOutIcon(Event event) {
  return Row(
    children: [
      Text(
        event.host[0],
        style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ),
    ],
  );
}

withIcon(Event event) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(
        Icons.power_off_outlined,
        size: 32,
        color: Colors.blueAccent,
      ),
      const SizedBox(width: 8),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.host[0],
            style: const TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          Text(
            event.host[1],
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black45.withOpacity(0.7),
                fontSize: 14),
          ),
        ],
      ),
    ],
  );
}
