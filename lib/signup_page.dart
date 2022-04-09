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

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
//  final String title;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  child: const Text("Screen 2"),
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
