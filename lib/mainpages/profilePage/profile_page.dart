import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/profilePage/account_info.dart';
import 'package:lets_connect/mainpages/profilePage/profile_info.dart';
import 'package:lets_connect/mainpages/profilePage/side_menu_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/login_page.dart';
import 'package:lets_connect/main.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
              fontFamily: 'Frutiger',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //     icon: const Icon(Icons.menu_rounded),
        //     iconSize: 30,
        //   )
        // ],
      ),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 30),
                width: MediaQuery.of(context).size.width,
                height: 230,
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  //  Color.fromARGB(255, 255, 215, 155),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // change how to get image
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/94/25/93/9425933cef85981844778fe55327f5da.jpg'),
                      radius:
                          55, //change to 60 if u want edit icon on the bottom
                    ),

                    //BUTTON TO CHANGE IMAGE
                    Positioned(
                        bottom: -10,
                        right: -15,
                        child: ElevatedButton(
                          onPressed: () {
                            //function to change image
                          },
                          child: const Icon(
                            Icons.create_rounded,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              //ACOUNT INFORMATION
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AccountInfo()));
                    //navigate to account info form
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
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
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
          children: const <Widget>[
            ProfileInfo(),
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //     child: Column(
      //   children: [
      //     Container(
      //       width: 200,
      //       height: 200,
      //       decoration: const BoxDecoration(color: Colors.blueAccent),
      //     )
      //   ],
      // )),
      // ),
    );
  }
}
