import 'package:flutter/material.dart';
import 'events_Data.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Events", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Colors.grey[300],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
           //mainAxisSize: MainAxisSize.max,
            children: posts.map((post) => postTemplate(post)).toList(),
          
         ),
        ),

      ),
      resizeToAvoidBottomInset: false,
      ),
    );
  }
}

//temp list for event posts
List<EventPost> posts = [
  EventPost(time: "time", sessionTitle: "sessionTitle", coordinator: "coordinator", attendees: "attendees", location: "location"),
  EventPost(time: "00:00", sessionTitle: "Temp Title", coordinator: "John Doe's Name", attendees: "Your Mom", location: "New York, NY"),
  EventPost(time: "00:00", sessionTitle: "Temp Title", coordinator: "John Doe's Name", attendees: "Your Mom", location: "New York, NY"),
  EventPost(time: "00:00", sessionTitle: "Temp Title", coordinator: "John Doe's Name", attendees: "Your Mom", location: "New York, NY"),
  EventPost(time: "00:00", sessionTitle: "Temp Title", coordinator: "John Doe's Name", attendees: "Your Mom", location: "New York, NY"),
  EventPost(time: "00:00", sessionTitle: "Temp Title", coordinator: "John Doe's Name", attendees: "Your Mom", location: "New York, NY"),
  EventPost(time: "00:00", sessionTitle: "Temp Title", coordinator: "John Doe's Name", attendees: "Your Mom", location: "New York, NY")
];

//event card layout
  Widget postTemplate(EventPost post){
  return FractionallySizedBox(

  
  child: Card(
    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    child: SizedBox(
          height: 100,
          width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            post.time,
            style: const TextStyle(
            fontSize: 19,
            //fontFeatures: FontFeature.underline,
            fontWeight: FontWeight.normal,
            color: Colors.orange),
          ),

          Text(
            post.sessionTitle,
            style: const TextStyle(
            fontSize: 20,
            //fontFeatures: FontFeature.underline,
            fontWeight: FontWeight.bold,
            color: Colors.black),
          ),

           Text(
            "Host: " + post.coordinator,
            style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54),
          ),

          Text(
            post.location,
            style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black54),
          ),
        ],

        ),
    ),
  ),);
}