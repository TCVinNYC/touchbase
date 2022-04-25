import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/eventsPage/events_page.dart';
import 'package:lets_connect/mainpages/profilePage/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final screens = [
    const Center(
        child: Text('Feed Page', style: TextStyle(fontSize: 60))), //FeedPage()
    const Center(
        child: Text('Connect Page',
            style: TextStyle(fontSize: 60))), //ConnectPage(),
    // const Center(
    //     child:
    //         Text('Add Page', style: TextStyle(fontSize: 60))), 
    const EventsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 9),
              child: GNav(
                rippleColor: Colors.orangeAccent,
                hoverColor: Colors.orangeAccent,
                gap: 1,
                activeColor: Colors.white,
                iconSize: 25,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                duration: const Duration(milliseconds: 200),
                tabBackgroundColor: Colors.orange,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Feed',
                  ),
                  GButton(
                    icon: Icons.public_rounded,
                    text: 'Connect',
                  ),
                  GButton(
                    icon: Icons.event_available_rounded,
                    text: 'Events',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
