import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/mainpages/profilePage/stat_list.dart';

class ProfileStatsCard extends StatelessWidget {
  final UserData userdata;
  const ProfileStatsCard({Key? key, required this.userdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 60),
        height: 90,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StatList(listName: "followers", user: userdata)),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Followers',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.followers.length.toString(),
                      //'16',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                indent: 15,
                endIndent: 15,
                thickness: 0.7,
                width: 0.5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StatList(listName: "following", user: userdata)),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Following',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.following.length.toString(),
                      //'16',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                indent: 15,
                endIndent: 15,
                thickness: 0.7,
                width: 0.5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StatList(listName: "posts", user: userdata)),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.postIDs.length.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                indent: 15,
                endIndent: 15,
                thickness: 0.7,
                width: 0.5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StatList(listName: "events", user: userdata)),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Events',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.eventIDs.length.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
