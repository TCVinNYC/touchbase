import 'package:flutter/material.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/mainpages/signupPage/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/mainpages/signupPage/enable_location.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final companyController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Background(),
      body: Stack(children: <Widget>[
        const Background(),
        SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //     padding: const EdgeInsets.fromLTRB(55, 10, 55, 0),
              //     child: Lottie.network(
              //       "https://assets4.lottiefiles.com/packages/lf20_z3pnisgt.json",
              //       repeat: true,
              //       // animate: true,
              //       fit: BoxFit.fitWidth,
              //     )),
              Container(
                height: 170,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 30),
                child: const Text(
                  "Welcome!\nCreate An Account",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(187, 255, 240, 206),
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person_rounded),
                      border: OutlineInputBorder()),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: "someone@example.com",
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                      border: OutlineInputBorder(),
                      labelText: "Email ID"),
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: 'Create Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()))),
              Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    User? user = await registerUsingEmailPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      name: nameController.text.trim(),
                      context: context,
                    );
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LocationPage()),
                      );
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: const Text(
                  "Or, sign up with...",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Spacer(flex: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.3,
                      height: MediaQuery.of(context).size.height / 13,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 0.6, color: Colors.black54),
                            backgroundColor: Colors.white.withOpacity(0.92),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                          signInWithGoogle();
                        },
                        child: Image.asset(
                          "assets/images/googleLogo.png",
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    //Apple Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.3,
                      height: MediaQuery.of(context).size.height / 13,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 0.6, color: Colors.black54),
                            backgroundColor: Colors.white.withOpacity(0.92),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                          signInWithApple(context);
                        },
                        child: Image.asset(
                          "assets/images/appleLogo.png",
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ),
                    const Spacer(flex: 4),
                  ],
                ),
                //Register Text and Button
              ),
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: const Text(''), // You can add title here
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor:
                Colors.orange.withOpacity(0.0), //You can make this transparent
            elevation: 0, //No shadow
          ),
        ),
      ]),
    );
  }
}
