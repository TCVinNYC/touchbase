import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/mainpages/eventsPage/view_event.dart';
import 'package:lets_connect/widgets/showDate.dart';
import 'package:lets_connect/widgets/showHost.dart';
import 'package:lets_connect/widgets/showLocation.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
                  showHost(event: event)
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

// Widget buildEventTemplate(context, Event event) {
//   return FractionallySizedBox(
//     child: Card(
//       elevation: 6,
//       margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//       //clipBehavior: Clip.antiAlias,
//       child: Column(
//         children: [
//           ListTile(
//             onTap: (() {
//               Navigator.push(context, MaterialPageRoute<void>(
//                 builder: (BuildContext context) {
//                   return ViewEventPage(event: event);
//                 },
//               ));
//             }),
//             trailing: InkWell(
//               onTap: () {},
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                 child: Icon(
//                   Icons.bookmark_border_outlined,
//                   size: 22,
//                 ),
//               ),
//               splashColor: Colors.amberAccent,
//               customBorder: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),

//             // trailing: IconButton(
//             //   onPressed: () {
//             //     _joined = true;
//             //   },
//             //   icon: const Icon(Icons.bookmark_border_outlined),
//             //   iconSize: 22,
//             //   splashColor: Colors.amber,
//             //   splashRadius: 22,
//             // ),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   event.time.toString(),
//                   style: const TextStyle(
//                       fontFamily: 'Quicksand',
//                       color: Colors.orange,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16),
//                 ),
//                 Text(
//                   event.sessionTitle,
//                   style: TextStyle(
//                       fontFamily: 'Quicksand',
//                       color: Colors.black.withOpacity(0.7),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 17),
//                 ),
//                 Text(
//                   event.host[0],
//                   style: TextStyle(
//                       fontFamily: 'Quicksand',
//                       color: Colors.black.withOpacity(0.8),
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14),
//                 ),
//               ],
//             ),
//             subtitle: Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 alignment: const Alignment(-1.035, 0),
//                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
//                 //alignment: Alignment.,
//                 child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.start,
//                   spacing: 2.3,
//                   children: [
//                     const Icon(
//                       Icons.location_pin,
//                       size: 18,
//                       color: Colors.blueAccent,
//                     ),
//                     Text(
//                       event.locationAddress,
//                       style: TextStyle(
//                           fontFamily: 'Quicksand',
//                           color: Colors.blue.withOpacity(0.9),
//                           fontSize: 15),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
