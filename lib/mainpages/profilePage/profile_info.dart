import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/mainpages/profilePage/profile_stats_card.dart';

class ProfileInfo extends StatelessWidget {
  final UserData userData;
  const ProfileInfo({required this.userData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 290,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage('assets/images/profile_bg.jpg'),
                // ),
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  //PROFILE PIC
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData.profilePic),
                    radius: 65,
                  ),

                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        //NAME
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            userData.name,
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //PRONOUNS
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            userData.prounouns,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // TITLE
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            userData.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //COMPANY
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            userData.company,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]))
                ]),
                //ABOUT ME
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    userData.aboutMe,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Frutiger',
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontSize: 16),
                  ),
                ),
              ],
            )),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: ProfileStatsCard(userdata: userData))
      ]),
    );
  }
}
