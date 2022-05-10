import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/mainpages/profilePage/stat_list.dart';

class ProfileInfo extends StatelessWidget {
  final UserData userData;
  const ProfileInfo({required this.userData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // PROFILE PIC
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(userData.profilePic),
                ),
                // NAME
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userData.name,
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Frutiger',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      '(' + userData.prounouns + ')',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Frutiger',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // PRONOUNS

                // TITLE
                Text(
                  userData.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Frutiger',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // COMPANY
                Text(
                  userData.company,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Frutiger',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orangeAccent),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Me',
                  style: TextStyle(
                      fontFamily: 'Frutiger',
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                // ABOUT ME
                Text(
                  userData.aboutMe,
                  style: const TextStyle(
                      // color: Colors.black,
                      fontFamily: 'Frutiger',
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          // STATS CARD
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orangeAccent),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                // FOLLOWERS BUTTON
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatList(listName: "followers", user: userData)),
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
                      //find a way to get followers amount
                      Text(
                        userData.followers.length.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 1,
                  width: 0.5,
                ),
                // FOLLOWING BUTTON
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatList(listName: "following", user: userData)),
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
                      //find a way to get following amount
                      Text(
                        userData.following.length.toString(),
                        //'16',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 1,
                  width: 0.5,
                ),
                // POSTS BUTTON
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatList(listName: "posts", user: userData)),
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
                      //find a way to get posts amount
                      Text(
                        userData.postIDs.length.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 1,
                  width: 0.5,
                ),
                // EVENTS BUTTON
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatList(listName: "events", user: userData)),
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
                      //find a way to get events amount
                      Text(
                        userData.eventIDs.length.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // )
          // ProfileStatsCard(userdata: userData)
        ],
      ),
    );
  }
}
