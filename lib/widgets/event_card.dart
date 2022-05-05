import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/mainpages/eventsPage/view_event.dart';
import 'package:lets_connect/widgets/showDate.dart';
import 'package:lets_connect/widgets/showHost.dart';
import 'package:lets_connect/widgets/showLocation.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  const EventWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        //clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return ViewEventPage(event: event);
                  },
                ))
              },
              trailing: InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Icon(
                    Icons.bookmark_border_outlined,
                    size: 22,
                  ),
                ),
                splashColor: Colors.amberAccent,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              // trailing: IconButton(
              //   onPressed: () {
              //     _joined = true;
              //   },
              //   icon: const Icon(Icons.bookmark_border_outlined),
              //   iconSize: 22,
              //   splashColor: Colors.amber,
              //   splashRadius: 22,
              // ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showDate(event: event),
                  Text(
                    event.sessionTitle,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  showHost(
                    event: event,
                    width: 30,
                    height: 30,
                  )
                ],
              ),
              subtitle: Align(
                alignment: Alignment.bottomLeft,
                child: showLocation(event: event),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
