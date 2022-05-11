import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/connectPage/connect_page.dart';
import 'package:lets_connect/mainpages/eventsPage/events_page.dart';
import 'package:lets_connect/mainpages/feedPage/feed_page.dart';
import 'package:lets_connect/mainpages/profilePage/main_profile_page.dart';
import 'package:lets_connect/mainpages/signupPage/enable_location.dart';
import 'package:lets_connect/mainpages/signupPage/userdetails.dart';

import 'feedPage/feed_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;
  late List<Widget> _pages;
  // late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    _pages = [
      const FeedPage(),
      const ConnectPage(),
       EventsPage(),
      const MainProfilePage(),
    ];
    //_pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    //_pageController.dispose();

    super.dispose();
  }

  late final Future? myFuture = getUser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              // body: PageView(
              //   controller: _pageController,
              //   physics: NeverScrollableScrollPhysics(),
              //   children: _pages,
              // ),
              body: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black.withOpacity(.7),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 9),
                    child: GNav(
                      rippleColor: Colors.orangeAccent,
                      hoverColor: Colors.orangeAccent,
                      gap: 1,
                      activeColor: Colors.white,
                      iconSize: 25,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      duration: const Duration(milliseconds: 200),
                      tabBackgroundColor: Colors.orange,
                      color: Colors.black,
                      tabs: const [
                        GButton(
                          icon: Icons.home,
                          text: ' Feed',
                        ),
                        GButton(
                          icon: Icons.public_rounded,
                          text: ' Connect',
                        ),
                        GButton(
                          icon: Icons.event_available_rounded,
                          text: ' Events',
                        ),
                        GButton(
                          icon: Icons.person,
                          text: ' Profile',
                        ),
                      ],
                      selectedIndex: _currentIndex,
                      onTabChange: (index) {
                        setState(() {
                          _currentIndex = index;
                          //_pageController.jumpToPage(_currentIndex);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }
      },
    );
  }

  Future<String> getUser() async {
    if (FireMethods.fireAuth.currentUser?.uid == null) {
      return "broke";
    }
    print("getting userData");
    UserData? userData =
        await FireMethods().getUserData(FireMethods.fireAuth.currentUser!.uid);
    if (userData != null) {
      print("set userData");
      UserPreferences.setUser(userData);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LocationPage()),
        (Route<dynamic> route) => false,
      );
    }
    return "done";
  }
}
