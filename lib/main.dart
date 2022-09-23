import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/login_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  FirebaseFirestore.instance.settings.persistenceEnabled;
  await UserPreferences.init();
  runApp(const MyApp());
}

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Touchbase",
      // themeMode: ThemeMode.system,
      // theme: MyThemes.lightTheme,
      // darkTheme: MyThemes.darkTheme,
      theme: ThemeData(fontFamily: 'Frutiger'),
      scaffoldMessengerKey: scaffoldMessengerKey,
      color: createMaterialColor(const Color.fromARGB(255, 255, 170, 12)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //signOutFromGoogle();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //this determines if the user has already logged in
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugPrint("startup");
              debugPrint(snapshot.data.toString());
              debugPrint("snapshot show");
              //if logged in, send to the main app
              return const MainPage();
            } else {
              //if not go to log in page
              return const LoginPage();
            }
          }),
    );
  }
}
