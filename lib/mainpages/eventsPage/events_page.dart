import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/eventsPage/filter_events_page.dart';
import 'events_Data.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _tabs = ['All Events', 'Your Events', 'Past Events'];

    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
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
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  splashFactory: InkRipple.splashFactory,
                  labelColor: Colors.black,
                  unselectedLabelColor: const Color.fromARGB(255, 32, 29, 29),
                  indicatorColor: Colors.amberAccent,
                  indicatorWeight: 3.2,
                  isScrollable: false,
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          // These are the contents of the tab views, below the tabs.
          children: <Widget>[
            SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: const PageStorageKey<String>('All Events'),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(3, 3, 3, 20),
                        sliver: SliverList(
                          // itemExtent: 48.0,
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return getAllEvents();
                              // return ListTile(
                              //   title: Text('Item $index'),
                              // );
                            },
                            childCount: 1,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: const PageStorageKey<String>('Your Events'),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(3, 3, 3, 20),
                        sliver: SliverList(
                          // itemExtent: 48.0,
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return getAllEvents2();
                              // return ListTile(
                              //   title: Text('Item $index'),
                              // );
                            },
                            childCount: 1,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: const PageStorageKey<String>('Past Events'),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(3, 3, 3, 20),
                        sliver: SliverList(
                          // itemExtent: 48.0,
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return getAllEvents3();
                            },
                            childCount: 1,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getAllEvents() {
  return Column(
    children: posts.map((post) => postTemplate(post)).toList(),
  );
}

getAllEvents2() {
  return Column(
    children: posts2.map((post) => postTemplate(post)).toList(),
  );
}

getAllEvents3() {
  return Column(
    children: posts3.map((post) => postTemplate(post)).toList(),
  );
}

//temp list for event posts
List<EventPost> posts = [
  EventPost(
      time: "12:30 PM",
      sessionTitle: "TALKING WITH JEFF",
      coordinator: "Jeff Chun",
      attendees: "ur mom 1",
      location: "New York, NY"),
  EventPost(
      time: "1:00 PM",
      sessionTitle: "Startup Panel",
      coordinator: "John Doe",
      attendees: "Your Mom",
      location: "San Franciso, CA"),
  EventPost(
      time: "9:45 PM",
      sessionTitle: "Happy Hour Meet & Greet",
      coordinator: "Kison Patel",
      attendees: "Your Mom",
      location: "Chicago, IL"),
  EventPost(
      time: "2:30PM",
      sessionTitle: "Boy Genius Talk",
      coordinator: "Jimmy Neutron",
      attendees: "Your Mom",
      location: "St. Augustine, FL"),
  EventPost(
      time: "8:10 AM",
      sessionTitle: "Kooking with Spongebob",
      coordinator: "Spongebob Squarepants",
      attendees: "Your Mom",
      location: "Bikini Bottom, SEA"),
  EventPost(
      time: "10:00 AM",
      sessionTitle: "Exploring w/ Dora",
      coordinator: "Dora the Explorer",
      attendees: "Your Mom",
      location: "Peruvian Jungle, Peru"),
  EventPost(
      time: "9:40 AM",
      sessionTitle: "Apple One Keynote",
      coordinator: "Tim Cook",
      attendees: "Your Mom",
      location: "Cupertino, CA"),
  EventPost(
      time: "6:00 AM",
      sessionTitle: "Getting Hooked",
      coordinator: "Patrick Star",
      attendees: "Your Mom",
      location: "Bikini Bottom, SEA"),
  EventPost(
      time: "9:00 AM",
      sessionTitle: "Beating Depression with Magic",
      coordinator: "Timmy Turner",
      attendees: "Your Mom",
      location: "Somewhere, AR"),
  EventPost(
      time: "5:00 PM",
      sessionTitle: "Fight the blue man",
      coordinator: "Kim Possible",
      attendees: "Your Mom",
      location: "Somewhere, Alabama"),
];

//temp list for event posts
List<EventPost> posts2 = [
  EventPost(
      time: "2:30PM",
      sessionTitle: "Boy Genius Talk",
      coordinator: "Jimmy Neutron",
      attendees: "Your Mom",
      location: "St. Augustine, FL"),
  EventPost(
      time: "8:10 AM",
      sessionTitle: "Kooking with Spongebob",
      coordinator: "Spongebob Squarepants",
      attendees: "Your Mom",
      location: "Bikini Bottom, SEA"),
  EventPost(
      time: "9:00 AM",
      sessionTitle: "Beating Depression with Magic",
      coordinator: "Timmy Turner",
      attendees: "Your Mom",
      location: "Somewhere, AR"),
  EventPost(
      time: "5:00 PM",
      sessionTitle: "Fight the blue man",
      coordinator: "Kim Possible",
      attendees: "Your Mom",
      location: "Somewhere, Alabama"),
];

//temp list for event posts
List<EventPost> posts3 = [
  EventPost(
      time: "12:30 PM",
      sessionTitle: "TALKING WITH JEFF",
      coordinator: "Jeff Chun",
      attendees: "ur mom 1",
      location: "New York, NY"),
  EventPost(
      time: "8:10 AM",
      sessionTitle: "Kooking with Spongebob",
      coordinator: "Spongebob Squarepants",
      attendees: "Your Mom",
      location: "Bikini Bottom, SEA"),
  EventPost(
      time: "10:00 AM",
      sessionTitle: "Exploring w/ Dora",
      coordinator: "Dora the Explorer",
      attendees: "Your Mom",
      location: "Peruvian Jungle, Peru"),
];

//event card layout
Widget postTemplate(EventPost post) {
  bool _joined = false;

  return FractionallySizedBox(
    child: Card(
      elevation: 6,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      //clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            trailing: InkWell(
              onTap: () => {},
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
                Text(
                  post.time,
                  style: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Text(
                  post.sessionTitle,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
                Text(
                  post.coordinator,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ],
            ),
            subtitle: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                alignment: Alignment(-1.035, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
                //alignment: Alignment.,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 2.3,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 18,
                      color: Colors.blueAccent,
                    ),
                    Text(
                      post.location,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.blue.withOpacity(0.9),
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
