import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/mainpages/signupPage/background.dart';

import 'package:lets_connect/mainpages/signupPage/signup_image.dart';

import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/mainpages/signupPage/enable_location.dart';
import 'package:lottie/lottie.dart';

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
                    User? user = await FireAuth.registerUsingEmailPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      name: nameController.text.trim(),
                      context: context,
                      //  title: title.trim(),
                      // company: company.trim(),
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
                            primary: Colors.white.withOpacity(0.92),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
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
                            primary: Colors.white.withOpacity(0.92),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
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



          // Container(
          //     padding:
          //         const EdgeInsets.only(top: 10, right: 35, left: 35, bottom: 10),
          //     child: TextField(
          //         decoration: InputDecoration(
          //             filled: true,
          //             fillColor: Colors.white70,
          //             hintText: 'Pronouns (Optional)',
          //             // prefixIcon: const Icon(Icons.person_rounded),
          //             border: OutlineInputBorder(
          //               borderSide: const BorderSide(),
          //               borderRadius: BorderRadius.circular(20),
          //             )))),


                        // Container(
              //   padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              //   child: TextField(
              //     controller: titleController,
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.white70,
              //       hintText: 'Title',
              //       prefixIcon: const Icon(Icons.content_paste_rounded),
              //       border: OutlineInputBorder(
              //         borderSide: const BorderSide(),
              //         borderRadius: BorderRadius.circular(7),
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.fromLTRB(25, 5, 25, 40),
              //   child: TextField(
              //       controller: companyController,
              //       decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colors.white70,
              //           hintText: 'Company',
              //           prefixIcon: const Icon(Icons.work_rounded),
              //           border: OutlineInputBorder(
              //             borderSide: const BorderSide(),
              //             borderRadius: BorderRadius.circular(7),
              //           ))),
              // ),
