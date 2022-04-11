import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

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
                    "assets/images/orange-coder.json",
                    repeat: true,
                    animate: true,
                    fit: BoxFit.fitWidth,
                  )),
              const Text("Screen 2"),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}