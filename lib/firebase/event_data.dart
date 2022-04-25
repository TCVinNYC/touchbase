import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_connect/mainpages/eventsPage/events_page.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
var today = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

// getEvents()  {
//   Stream<QuerySnapshot> snapshot =  FirebaseFirestore.instance
//       .collection('events')
//       .where('date', isGreaterThanOrEqualTo: today)
//       .snapshots();


//   return  StreamBuilder<QuerySnapshot>(
//   stream: snapshot,
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) return const LinearProgressIndicator();

//     return buildEventsList(context, snapshot.data?.docs ?? []);
//   });

// }
  // List<Event> _eventList = [];

  // snapshot.forEach((document) {
  //   Event food = Event.fromMap(document.data);
  //   _eventList.add(food);
  // });

  // eventNotifier.eventList = _eventList;



// getEventsList() {
//   final Stream<QuerySnapshot> eventCollectionStream = FirebaseFirestore.instance
//       .collection('events')
      // .where('date', isGreaterThanOrEqualTo: today)
      // .snapshots();

//   return StreamBuilder<QuerySnapshot>(
//       stream: eventCollectionStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }
       

//       });
// }
// getEventsList() {
//   Stream eventCollections = FirebaseFirestore.instance
// .collection('events')
// .where('date', isGreaterThanOrEqualTo: today)
//           .snapshots(),

//       builder;
//   (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//     if (snapshot.hasError) {
//       return Text("Something went wrong");
//     }

//     if (snapshot.hasData && !snapshot.data!.exists) {
//       return Text("Document does not exist");
//     }

//     if (!snapshot.hasData) {
//       return Text("loading");
//     }

//     if (snapshot.connectionState == ConnectionState.done) {
//       return snapshot.data!.data() as Map<String, dynamic>;
//       //Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//       // return EventModel(id: 1, time: data['time'], sessionTitle: data['event_name'], coordinator: data['host'], attendees: data['attendees'], location: data['location']);
//     }
//   };
// }

// Stream<QuerySnapshot> getEventsList(BuildContext context) async* {
//   yield* FirebaseFirestore.instance
//       .collection('events')
//       //.where('date', isGreaterThanOrEqualTo: today)
//       .snapshots();

// }

  // return FutureBuilder<DocumentSnapshot>(
  //   builder:
  //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

  //     if (snapshot.hasError) {
  //       return Text("Something went wrong!");
  //     }

  //     if (snapshot.hasData && !snapshot.data!.exists) {
  //       return Text("No Events!");
  //     }

  //     if (snapshot.connectionState == ConnectionState.done) {
  //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //       return Text("Full Name: ${data['full_name']} ${data['last_name']}");
  //     }

  //     return Text("loading");
  //   },
  // );

