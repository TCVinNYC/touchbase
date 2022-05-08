import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/mainpages/eventsPage/create_event.dart';
import 'package:lets_connect/mainpages/eventsPage/filter_events_page.dart';
import 'package:lets_connect/widgets/event_card.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<EventsPage> {
  late TabController _tabController;
  late ScrollController _scrollViewController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              title: const Text(
                'Search Events',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w800,
                    fontSize: 25),
                textAlign: TextAlign.start,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                  ),
                  tooltip: 'Filter Options',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const FilterEventsPage();
                      },
                    ));
                  },
                )
              ],
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                physics: const NeverScrollableScrollPhysics(),
                labelColor: Colors.black,
                unselectedLabelColor: const Color.fromARGB(255, 32, 29, 29),
                indicatorColor: Colors.amberAccent,
                indicatorWeight: 3.2,
                isScrollable: false,
                tabs: const <Widget>[
                  Tab(text: "New"),
                  Tab(text: "Upcoming"),
                  Tab(text: "Missed")
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            AllEventsPage(),
            YourEventsPage(),
            PastEventsPage(),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        splashColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return const CreateEventPage();
            },
          ));
        },
      ),
    );
  }
}

class AllEventsPage extends StatelessWidget {
  const AllEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: StreamBuilder<List<Event>>(
        key: Key("${Random().nextDouble()}"),
        stream: getAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return EventWidget(
                  event: events[index],
                  showBookmark: true,
                );
              },
              itemCount: events.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class YourEventsPage extends StatelessWidget {
  const YourEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: StreamBuilder<List<Event>>(
        stream: getYourEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return EventWidget(
                  event: events[index],
                  showBookmark: true,
                );
              },
              itemCount: events.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PastEventsPage extends StatelessWidget {
  const PastEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: StreamBuilder<List<Event>>(
        stream: getPastEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return EventWidget(
                  event: events[index],
                  showBookmark: false,
                );
              },
              itemCount: events.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

UserData user = UserPreferences.getUser();
Stream<List<Event>> getAllEvents() {
  if (UserPreferences.getUser().eventIDs.isNotEmpty) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('id', whereNotIn: UserPreferences.getUser().eventIDs)
        .orderBy('time', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList())
        .map((event) => event
            .where((event) =>
                event.time.millisecondsSinceEpoch >=
                DateTime.now().millisecondsSinceEpoch)
            .toList());
  } else {
    return FirebaseFirestore.instance
        .collection('events')
        .where('time', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('time', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }
}

Stream<List<Event>> getYourEvents() => FirebaseFirestore.instance
    .collection('events')
    .where('attendees', arrayContainsAny: [user.userID])
    .where("time", isGreaterThanOrEqualTo: DateTime.now())
    .orderBy('time', descending: false)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

Stream<List<Event>> getPastEvents() => FirebaseFirestore.instance
    .collection('events')
    .where('id', whereNotIn: UserPreferences.getUser().eventIDs)
    .orderBy('time', descending: true)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList())
    .map((event) => event
        .where((event) =>
            event.time.millisecondsSinceEpoch <=
            DateTime.now().millisecondsSinceEpoch)
        .toList());

// Stream<List<Event>> getPastEvents() => FirebaseFirestore.instance
//     .collection('events')
//     .where("time", isLessThan: DateTime.now())
//     .where('attendees', arrayContainsAny: [user.userID])
//     .snapshots()
//     .map((snapshot) =>
//         snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

// //temp list for event posts
// List<EventPost> posts = [
//   EventPost(
//       time: "12:30 PM",
//       sessionTitle: "TALKING WITH JEFF",
//       coordinator: "Jeff Chun",
//       attendees: "ur mom 1",
//       location: "New York, NY"),

//   EventPost(
//       time: "2:30PM",
//       sessionTitle: "Boy Genius Talk",
//       coordinator: "Jimmy Neutron",
//       attendees: "Your Mom",
//       location: "St. Augustine, FL"),
//   EventPost(
//       time: "8:10 AM",
//       sessionTitle: "Kooking with Spongebob",
//       coordinator: "Spongebob Squarepants",
//       attendees: "Your Mom",
//       location: "Bikini Bottom, SEA"),
//   EventPost(
//       time: "10:00 AM",
//       sessionTitle: "Exploring w/ Dora",
//       coordinator: "Dora the Explorer",
//       attendees: "Your Mom",
//       location: "Peruvian Jungle, Peru"),
//   EventPost(
//       time: "9:40 AM",
//       sessionTitle: "Apple One Keynote",
//       coordinator: "Tim Cook",
//       attendees: "Your Mom",
//       location: "Cupertino, CA"),
//   EventPost(
//       time: "6:00 AM",
//       sessionTitle: "Getting Hooked",
//       coordinator: "Patrick Star",
//       attendees: "Your Mom",
//       location: "Bikini Bottom, SEA"),
//   EventPost(
//       time: "9:00 AM",
//       sessionTitle: "Beating Depression with Magic",
//       coordinator: "Timmy Turner",
//       attendees: "Your Mom",
//       location: "Somewhere, AR"),
//   EventPost(
//       time: "5:00 PM",
//       sessionTitle: "Fight the blue man",
//       coordinator: "Kim Possible",
//       attendees: "Your Mom",
//       location: "Somewhere, Alabama"),
// ];

// //temp list for event posts
// List<EventPost> posts2 = [
//   EventPost(
//       time: "2:30PM",
//       sessionTitle: "Boy Genius Talk",
//       coordinator: "Jimmy Neutron",
//       attendees: "Your Mom",
//       location: "St. Augustine, FL"),
//   EventPost(
//       time: "8:10 AM",
//       sessionTitle: "Kooking with Spongebob",
//       coordinator: "Spongebob Squarepants",
//       attendees: "Your Mom",
//       location: "Bikini Bottom, SEA"),
//   EventPost(
//       time: "9:00 AM",
//       sessionTitle: "Beating Depression with Magic",
//       coordinator: "Timmy Turner",
//       attendees: "Your Mom",
//       location: "Somewhere, AR"),
//   EventPost(
//       time: "5:00 PM",
//       sessionTitle: "Fight the blue man",
//       coordinator: "Kim Possible",
//       attendees: "Your Mom",
//       location: "Somewhere, Alabama"),
// ];

// //temp list for event posts
// List<EventPost> posts3 = [
//   EventPost(
//       time: "12:30 PM",
//       sessionTitle: "TALKING WITH JEFF",
//       coordinator: "Jeff Chun",
//       attendees: "ur mom 1",
//       location: "New York, NY"),
//   EventPost(
//       time: "8:10 AM",
//       sessionTitle: "Kooking with Spongebob",
//       coordinator: "Spongebob Squarepants",
//       attendees: "Your Mom",
//       location: "Bikini Bottom, SEA"),
//   EventPost(
//       time: "10:00 AM",
//       sessionTitle: "Exploring w/ Dora",
//       coordinator: "Dora the Explorer",
//       attendees: "Your Mom",
//       location: "Peruvian Jungle, Peru"),
// ];
