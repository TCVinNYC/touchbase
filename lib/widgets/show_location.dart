import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:maps_launcher/maps_launcher.dart';

// ignore: camel_case_types
class show_location extends StatelessWidget {
  const show_location({
    Key? key,
    required this.event,
    this.showName,
  }) : super(key: key);

  final Event event;
  final bool? showName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        MapsLauncher.launchQuery(event.locationAddress);
      }),
      child: Container(
        alignment: const Alignment(-1.035, 0),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
        //alignment: Alignment.,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 2.3,
          children: [
            showName == null ? withOutName(event) : withName(event),
          ],
        ),
      ),
    );
  }
}

withOutName(Event event) {
  return Row(
    children: [
      const Icon(
        Icons.location_pin,
        size: 18,
        color: Colors.blueAccent,
      ),
      Text(
        event.locationAddress,
        style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.blue.withOpacity(0.9),
            fontSize: 15),
      )
    ],
  );
}

withName(Event event) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(
        Icons.location_pin,
        size: 32,
        color: Colors.blueAccent,
      ),
      const SizedBox(width: 8),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.locationName,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 17)),
          Text(
            event.locationAddress,
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black45.withOpacity(0.7),
                fontSize: 12),
          ),
        ],
      ),
    ],
  );
}
