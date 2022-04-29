import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/signupPage/background.dart';
import 'package:lets_connect/mainpages/signupPage/signup_image.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          padding: const EdgeInsets.only(right: 35, left: 35, bottom: 45),
          child: const Text(
            'Create Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 35, left: 35, bottom: 7),
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(187, 255, 240, 206),
                hintText: 'Name',
                prefixIcon: const Icon(Icons.person_rounded),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        Container(
            padding:
                const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
            child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    )))),
        Container(
            padding:
                const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 50),
            child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Create Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    )))),
        SizedBox(
            height: 50,
            width: 260,
            // width: MediaQuery.of(context).size.width / 1.5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUpImage()));
              },
              child: const Text('Sign Up',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
            )),
      ]),
    );
  }
}
