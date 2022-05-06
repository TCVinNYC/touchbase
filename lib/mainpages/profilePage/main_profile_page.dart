import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/mainpages/profilePage/profile_details.dart';
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
  late UserData user;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    UserData user = UserPreferences.getUser();
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
                    imageAsset: Image.network(user.profilePic)),
              ),
              //ACOUNT INFORMATION
              InkWell(
                  onTap: () {
                    //navigate to account info form
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AccountInfo(userData: user)));
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
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Coming Soon")));
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
            ProfileInfo(userData: user),
          ],
        ),
      ),
    );
  }
}
