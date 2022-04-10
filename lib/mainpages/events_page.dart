import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  ;
  return MaterialColor(color.value, swatch);
}

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
//  final String title;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Events", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Colors.grey[350],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.deepOrange,
        buttonBackgroundColor: Colors.white,
        // height: 70,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOutCubic,
        index: 3,
        items: const <Widget>[
          Icon(Icons.home_filled, size: 30, color: Colors.orange),
          Icon(Icons.public_rounded, size: 30, color: Colors.orange),
          Icon(Icons.publish_rounded, size: 30, color: Colors.orange),
          Icon(Icons.event_available_rounded, size: 30, color: Colors.orange),
          Icon(Icons.person, size: 30, color: Colors.orange),
        ],
        onTap: (index) {
          debugPrint("Current Index is $index");
        },
      ),
    ));
  }
}

class LottieScreen extends StatefulWidget {
  const LottieScreen({Key? key}) : super(key: key);

  @override
  _LottieScreenState createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottie Implementation"),
        centerTitle: true,
      ),
    );
  }
}
