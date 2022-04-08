import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let's Connect",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: createMaterialColor(Color.fromARGB(255, 255, 170, 12)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Lottie.asset(
                    "assets/orange-coder.json",
                    repeat: true,
                    animate: true,
                    fit: BoxFit.fitWidth,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Login",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "someone@example.com",
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                      // suffixIcon: _controller.text.isEmpty
                      //     ? null // Show nothing if the text field is empty
                      //     : IconButton(
                      //         icon: const Icon(Icons.clear),
                      //         onPressed: _clearTextField,
                      //       ), // Show the clear button if the text field has something
                      border: OutlineInputBorder(),
                      labelText: "Email ID"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: "Password"),
                  obscureText: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width / 1.6,
                height: MediaQuery.of(context).size.width / 5.5,
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(50),
                child: Text(
                  "Or, log in with...",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
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
