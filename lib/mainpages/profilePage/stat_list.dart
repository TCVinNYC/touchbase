import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/datamodels/post_model.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/mainpages/eventsPage/events_page.dart';
import 'package:lets_connect/widgets/connect_widget.dart';
import 'package:lets_connect/widgets/event_card.dart';
import 'package:lets_connect/widgets/post_widget.dart';

class StatList extends StatefulWidget {
  final String listName;
  final UserData user;
  const StatList({Key? key, required this.listName, required this.user})
      : super(key: key);

  @override
  State<StatList> createState() => _StatListPageState();
}

class _StatListPageState extends State<StatList> {
  @override
  Widget build(BuildContext context) {
    if (widget.listName == "events") {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.orange,
        ),
        body: Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              bottom: false,
              child: widget.user.eventIDs.isEmpty
                  ? const Center(
                      child: Text(
                      "No Events",
                      style: TextStyle(fontSize: 20),
                    ))
                  : getEventsShow(widget.user),
            )),
      );
    } else if (widget.listName == "posts") {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.orange,
        ),
        body: Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              bottom: false,
              child: widget.user.likedPosts.isEmpty
                  ? const Center(
                      child: Text(
                      "No Posts",
                      style: TextStyle(fontSize: 20),
                    ))
                  : getPostsShow(widget.user),
            )),
      );
    } else if (widget.listName == "following") {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.orange,
        ),
        body: Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              bottom: false,
              child: widget.user.following.isEmpty
                  ? const Center(
                      child: Text(
                      "Not Following Anyone",
                      style: TextStyle(fontSize: 20),
                    ))
                  : getFollowing(widget.user),
            )),
      );
    } else if (widget.listName == "followers") {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.orange,
        ),
        body: Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              bottom: false,
              child: widget.user.followers.isEmpty
                  ? const Center(
                      child: Text(
                      "No Followers",
                      style: TextStyle(fontSize: 20),
                    ))
                  : getFollowers(widget.user),
            )),
      );
    }
    return Container();
  }

  FutureBuilder<List<Event>> getEventsShow(UserData user) {
    return FutureBuilder<List<Event>>(
      future: FirebaseFirestore.instance
          .collection('events')
          .where('attendees', arrayContains: user.userID)
          // .orderBy('time', descending: false)
          .get()
          .then((snapshot) =>
              snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList()),
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
    );
  }

  FutureBuilder<List<Post>> getPostsShow(UserData user) {
    return FutureBuilder<List<Post>>(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('poster', arrayContains: user.userID)
            .get()
            .then((snapshot) =>
                snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return FeedPost(
                  post: posts[index],
                  user: user,
                );
              },
              itemCount: posts.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  FutureBuilder<List<UserData>> getFollowing(UserData user) {
    return FutureBuilder<List<UserData>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('id', whereIn: user.following)
            .get()
            .then((snapshot) => snapshot.docs
                .map((doc) => UserData.fromJson(doc.data()))
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ConnectWidget(
                  user: users[index],
                  myUser: UserPreferences.getUser(),
                );
              },
              itemCount: users.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  FutureBuilder<List<UserData>> getFollowers(UserData user) {
    return FutureBuilder<List<UserData>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('id', whereIn: user.followers)
            .get()
            .then((snapshot) => snapshot.docs
                .map((doc) => UserData.fromJson(doc.data()))
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something when wrong!" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ConnectWidget(
                  user: users[index],
                  myUser: UserPreferences.getUser(),
                );
              },
              itemCount: users.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

// Future<List<Post>> getPosts(UserData user) {
//   return 
// }



    // var userTemp = UserPreferences.getUser();
    // if (userTemp.following.isNotEmpty) {
    //   temp = await FirebaseFirestore.instance
    //       .collection('users')
    //       .where('id', whereNotIn: userTemp.following)
    //       .get()
    //       .then((value) =>
    //           value.docs.map((doc) => UserData.fromJson(doc.data())).toList())
    //       .then((value) =>
    //           value.where((value) => value.userID != userTemp.userID).toList());
    // } else {
    //   temp = await FirebaseFirestore.instance.collection('users').get().then(
    //       (snapshot) => snapshot.docs
    //           .map((doc) => UserData.fromJson(doc.data()))
    //           .toList());
    // }






