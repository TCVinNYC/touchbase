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

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
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
                      fontSize: 24),
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
                bottom: const TabBar(
                  physics: NeverScrollableScrollPhysics(),
                  labelColor: Colors.black,
                  unselectedLabelColor: Color.fromARGB(255, 32, 29, 29),
                  indicatorColor: Colors.amberAccent,
                  indicatorWeight: 3.2,
                  isScrollable: false,
                  tabs: <Widget>[
                    Tab(text: "New"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Missed")
                  ],
                ),
              )
            ];
          },
          body: const TabBarView(
            children: <Widget>[
              AllEventsPage(),
              YourEventsPage(),
              PastEventsPage(),
            ],
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

class YourEventsPage extends StatefulWidget {
  const YourEventsPage({Key? key}) : super(key: key);
  @override
  _YourEventsPageState createState() => _YourEventsPageState();
}

class _YourEventsPageState extends State<YourEventsPage>
    with AutomaticKeepAliveClientMixin<YourEventsPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
  @override
  bool get wantKeepAlive => true;
}

class PastEventsPage extends StatefulWidget {
  const PastEventsPage({Key? key}) : super(key: key);
  @override
  _PastEventsPageState createState() => _PastEventsPageState();
}

class _PastEventsPageState extends State<PastEventsPage>
    with AutomaticKeepAliveClientMixin<PastEventsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
  @override
  bool get wantKeepAlive => true;
}

UserData user = UserPreferences.getUser();
Stream<List<Event>> getAllEvents() {
  if (UserPreferences.getUser().eventIDs.isNotEmpty) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('id', whereNotIn: UserPreferences.getUser().eventIDs)
        // .orderBy('time', descending: false)
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
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }
}

Stream<List<Event>> getYourEvents() => FirebaseFirestore.instance
    .collection('events')
    .where('attendees', arrayContainsAny: [user.userID])
    .where("time", isGreaterThanOrEqualTo: DateTime.now())
    //.orderBy('time', descending: false)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

Stream<List<Event>> getPastEvents() {
  if (UserPreferences.getUser().eventIDs.isNotEmpty) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('id', whereNotIn: UserPreferences.getUser().eventIDs)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList())
        .map((event) => event
            .where((event) =>
                event.time.millisecondsSinceEpoch <
                DateTime.now().millisecondsSinceEpoch)
            .toList());
  } else {
    return FirebaseFirestore.instance
        .collection('events')
        .where('time', isLessThan: DateTime.now())
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }
}
