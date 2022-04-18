import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lets_connect/login_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//import 'src/authentication.dart';
//import 'src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/mainpages/signupPage/signup.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Touchbase",
      theme: ThemeData(fontFamily: 'Frutiger'),
      //  fontFamily: 'Frutiger',
      //primaryColor: createMaterialColor(const Color.fromARGB(255, 255, 170, 12)),

      //primarySwatch: createMaterialColor(Color.fromARGB(255, 255, 170, 12)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainPage();
              } else {
                return const LoginPage();
              }
            }),
      );
}
