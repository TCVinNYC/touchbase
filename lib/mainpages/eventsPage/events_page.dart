import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/mainpages/eventsPage/create_event.dart';
import 'package:lets_connect/mainpages/eventsPage/filter_events_page.dart';
import 'package:lets_connect/mainpages/eventsPage/view_event.dart';
import 'package:lets_connect/widgets/event_card.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;

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
              snap: false,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                physics: const NeverScrollableScrollPhysics(),
                labelColor: Colors.black,
                unselectedLabelColor: const Color.fromARGB(255, 32, 29, 29),
                indicatorColor: Colors.amberAccent,
                indicatorWeight: 3.2,
                isScrollable: false,
                tabs: const <Widget>[
                  Tab(text: "All Events"),
                  Tab(text: "Your Events"),
                  Tab(text: "Past Events")
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: const <Widget>[
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
        stream: getAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot);
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return EventWidget(
                  event: events[index],
                );
              },
              itemCount: events.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
            //return ListView(children: events.map(buildEventTemplate(context)).toList());
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
        print(FirebaseAuth.instance.currentUser?.uid);
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            print(events);
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return EventWidget(
                  event: events[index],
                );
              },
              itemCount: events.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
            //return ListView(children: events.map(buildEventTemplate(context)).toList());
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
            return Text("Something when wrong!" + snapshot.toString());
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return Container();
            //return ListView(children: events.map(buildEventTemplate).toList());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Stream<List<Event>> getAllEvents() => FirebaseFirestore.instance
    .collection('events')
    //.where('attendees', arrayContainsAny: [user!.uid])
    .where("time", isGreaterThanOrEqualTo: DateTime.now())
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

Stream<List<Event>> getYourEvents() => FirebaseFirestore.instance
    .collection('events')
    .where('attendees', arrayContainsAny: [FirebaseAuth.instance.currentUser?.uid])
    .where("time", isGreaterThanOrEqualTo: DateTime.now())
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

Stream<List<Event>> getPastEvents() => FirebaseFirestore.instance
    .collection('events')
    .where("time", isLessThan: DateTime.now())
    .where('attendees', arrayContainsAny: [FirebaseAuth.instance.currentUser?.uid])
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());



//List<String> _tabs = ['All Events', 'Your Events', 'Past Events'];

// return DefaultTabController(
//   length: _tabs.length, // This is the number of tabs.
//   child: NestedScrollView(
//     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//       // These are the slivers that show up in the "outer" scroll view.
//       return <Widget>[
//         SliverOverlapAbsorber(
//           handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//           sliver: 
// SliverAppBar(
//             backgroundColor: Colors.white,
//             centerTitle: false,
//             title: const Text(
//               'Search Events',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Quicksand',
//                   fontWeight: FontWeight.w800,
//                   fontSize: 25),
//               textAlign: TextAlign.start,
//             ),
//             actions: <Widget>[
//               IconButton(
//                 icon: const Icon(
//                   Icons.menu_rounded,
//                   color: Colors.black,
//                 ),
//                 tooltip: 'Filter Options',
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute<void>(
//                     builder: (BuildContext context) {
//                       return const FilterEventsPage();
//                     },
//                   ));
//                 },
//               )
//             ],
//             pinned: true,
//             floating: true,
//             snap: false,
//             forceElevated: innerBoxIsScrolled,
//             bottom: TabBar(
//               // splashFactory: InkRipple.splashFactory,
//               labelColor: Colors.black,
//               unselectedLabelColor: const Color.fromARGB(255, 32, 29, 29),
//               indicatorColor: Colors.amberAccent,
//               indicatorWeight: 3.2,
//               isScrollable: false,
//               tabs: _tabs.map((String name) => Tab(text: name)).toList(),
//             ),
//           ),
//         ),
//       ];
//     },

//     //Tabs
//     body: TabBarView(
//       physics: const NeverScrollableScrollPhysics(),
//       // These are the contents of the tab views, below the tabs.
//       children: [
//         //All Events
//         SafeArea(
          // top: false,
          // bottom: false,
//           child: Builder(
//             builder: (BuildContext context) {
//               return CustomScrollView(
//                 key: const PageStorageKey<String>('All Events'),
//                 slivers: <Widget>[
//                   SliverOverlapInjector(
//                     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                         context),
//                   ),
//                   SliverPadding(
//                     padding: const EdgeInsets.fromLTRB(3, 3, 3, 20),
//                     sliver: SliverList(
//                       // itemExtent: 48.0,
//                       delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                           return buildEventsList(context);
//                           //return getEvents();
//                           //return getAllEvents(context);
//                           // return ListTile(
//                           //   title: Text('Item $index'),
//                           // );
//                         },
//                         childCount: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),

//         //Your Events
//         SafeArea(
//           top: false,
//           bottom: false,
//           child: Builder(
//             builder: (BuildContext context) {
//               return CustomScrollView(
//                 key: const PageStorageKey<String>('Your Events'),
//                 slivers: <Widget>[
//                   SliverOverlapInjector(
//                     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                         context),
//                   ),
//                   SliverPadding(
//                     padding: const EdgeInsets.fromLTRB(3, 3, 3, 20),
//                     sliver: SliverList(
//                       // itemExtent: 48.0,
//                       delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                           // print(getEventsList());
//                           //return getAllEvents2();
//                           return ListTile(
//                             title: Text('Item $index'),
//                           );
//                         },
//                         childCount: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),

//         //Past Events
//         SafeArea(
//           top: false,
//           bottom: false,
//           child: Builder(
//             builder: (BuildContext context) {
//               return CustomScrollView(
//                 key: const PageStorageKey<String>('Past Events'),
//                 slivers: <Widget>[
//                   SliverOverlapInjector(
//                     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                         context),
//                   ),
//                   SliverPadding(
//                     padding: const EdgeInsets.fromLTRB(3, 3, 3, 20),
//                     sliver: SliverList(
//                       // itemExtent: 48.0,
//                       delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                           //return getAllEvents3();
//                         },
//                         childCount: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   ),
// );








// getAllEvents(context) {
//   var documents = getEventsList();
//  return ListView.separated(
//           itemBuilder: (BuildContext context, int index) {
//             return eventsTemplate(context, documents);
//           },
//           itemCount: documents.length,
//           separatorBuilder: (BuildContext context, int index) {
//             return Divider(
//               color: Colors.black,
//             );
//           },
//         );
// }

// getAllEvents2() {
//   return Column(
//     children: posts2.map((post) => postTemplate(post)).toList(),
//   );
// }

// getAllEvents3() {
//   return Column(
//     children: posts3.map((post) => postTemplate(post)).toList(),
//   );
// }

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