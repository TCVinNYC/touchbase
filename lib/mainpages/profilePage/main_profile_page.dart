import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/firebase/firestore.dart';

import 'package:lets_connect/mainpages/profilePage/account_settings.dart';

import 'package:lets_connect/mainpages/profilePage/profile_details.dart';
// import 'package:lets_connect/mainpages/profilePage/unused/profile_info.dart';
import 'package:lets_connect/mainpages/profilePage/profile_info.dart';
import 'package:lets_connect/mainpages/profilePage/side_menu_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/main.dart';
import 'package:lets_connect/widgets/image_widget.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key? key}) : super(key: key);

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  UserData userData = UserPreferences.getUser();

  Stream<UserData> updateUserData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FireMethods.fireAuth.currentUser!.uid)
        .snapshots()
        .map((event) => UserData.fromJson(event.data()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'My Profile',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          // iconTheme: const IconThemeData(color: Colors.orange),
        ),
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                  ),
                  //CHANGE IMAGE
                  child: ImageWidget(
                      circular: true,
                      width: 150,
                      height: 150,
                      enableEditButton: true,
                      colorInvert: true,
                      enableImageInk: false,
                      imageAsset: Image.network(userData.profilePic)),
                ),
                //ACOUNT INFORMATION
                InkWell(
                    onTap: () {
                      //navigate to profile details form
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProfileDetails(userData: userData)));
                    },
                    child: SideMenu(
                        icon: Icons.account_circle_rounded,
                        icon_color: Colors.deepOrangeAccent,
                        text: 'Profile Details')),
                const Divider(thickness: 1),
                //NOTIFICATIONS
                InkWell(
                    onTap: () {
                      //navigate to notifications form

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Coming Soon")));
                    },
                    child: SideMenu(
                        icon: Icons.notifications_rounded,
                        icon_color: Colors.indigoAccent,
                        text: 'Notifications')),
                const Divider(
                  thickness: 1,
                ),
                //SETTINGS
                InkWell(
                  onTap: () {
                    //navigate to settings form
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AccountSettings()));
                  },
                  child: SideMenu(
                      icon: Icons.settings_rounded,
                      icon_color: Colors.blueGrey,
                      text: "Settings"),
                ),
                const Divider(thickness: 1),
                // LOGOUT
                InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.currentUser!.reload();
                      await signOutFromGoogle();
                      UserPreferences.resetUser();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const MyHomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: SideMenu(
                        icon: Icons.logout_rounded,
                        icon_color: Colors.red,
                        text_color: Colors.red,
                        text: 'Log Out')),
              ],
            ),
          ),
        ),
        //BODY
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<UserData>(
                  stream: updateUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          "Something when wrong!" + snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      final userDown = snapshot.data!;

                      return ProfileInfo(userData: userDown);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ));
  }
}
