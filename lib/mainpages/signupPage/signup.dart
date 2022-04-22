import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/mainpages/signupPage/background.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  String email = "";
  String password = "";
  String name = "";
  String title = "";
  String company = "";

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
            // alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(right: 35, left: 35, bottom: 45),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 35, left: 35, bottom: 7),
            child: TextField(
              controller: nameController,
              onChanged: (text) {
                name = text;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(187, 255, 240, 206),
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person_rounded),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
          Container(
              padding:
                  const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
              child: TextField(
                  controller: emailController,
                  onChanged: (text) {
                    email = text;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(20),
                      )))),
          Container(
              padding:
                  const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
              child: TextField(
                  controller: passwordController,
                  onChanged: (text) {
                    password = text;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Create Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(20),
                      )))),
          Container(
            padding:
                const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
            child: TextField(
                controller: titleController,
                onChanged: (text) {
                  title = text;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Title',
                    prefixIcon: const Icon(Icons.content_paste_rounded),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(20),
                    ))),
          ),
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
          Container(
            padding:
                const EdgeInsets.only(top: 10, right: 35, left: 35, bottom: 50),
            child: TextField(
                controller: companyController,
                onChanged: (text) {
                  company = text;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Company',
                    prefixIcon: const Icon(Icons.work_rounded),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(20),
                    ))),
          ),
          SizedBox(
            height: 50,
            width: 160,
            child: ElevatedButton(
              child: const Text('Continue',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.lightBlue),
                )),
              ),
              onPressed: () async {
                User? user = await FireAuth.registerUsingEmailPassword(
                  email: email.trim(),
                  password: password.trim(),
                  // company: company.trim(),
                  name: name.trim(), context: context,
                  //  title: title.trim(),
                );
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}

// class Body extends StatelessWidget {
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  // final nameController = TextEditingController();
  // final titleController = TextEditingController();

//   const Body({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
//           Widget>[
//         Container(
//           // alignment: Alignment.topLeft,
//           padding: const EdgeInsets.only(right: 35, left: 35, bottom: 45),
//           child: const Text(
//             'Sign Up',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 40,
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.only(right: 35, left: 35, bottom: 7),
//           child: TextField(
//             decoration: InputDecoration(
//                 filled: true,
//                 fillColor: const Color.fromARGB(187, 255, 240, 206),
//                 hintText: 'Name',
//                 prefixIcon: const Icon(Icons.person_rounded),
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(),
//                   borderRadius: BorderRadius.circular(20),
//                 )),
//           ),
//         ),
//         Container(
//             padding:
//                 const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
//             child: TextField(
//                 decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white70,
//                     hintText: 'Email',
//                     prefixIcon: const Icon(Icons.alternate_email),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(),
//                       borderRadius: BorderRadius.circular(20),
//                     )))),
//         Container(
//             padding:
//                 const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
//             child: TextField(
//                 decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white70,
//                     hintText: 'Create Password',
//                     prefixIcon: const Icon(Icons.lock),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(),
//                       borderRadius: BorderRadius.circular(20),
//                     )))),
//         Container(
//           padding:
//               const EdgeInsets.only(top: 7, right: 35, left: 35, bottom: 7),
//           child: TextField(
//               decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white70,
//                   hintText: 'Title',
//                   prefixIcon: const Icon(Icons.content_paste_rounded),
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(),
//                     borderRadius: BorderRadius.circular(20),
//                   ))),
//         ),
//         // Container(
//         //     padding:
//         //         const EdgeInsets.only(top: 10, right: 35, left: 35, bottom: 10),
//         //     child: TextField(
//         //         decoration: InputDecoration(
//         //             filled: true,
//         //             fillColor: Colors.white70,
//         //             hintText: 'Pronouns (Optional)',
//         //             // prefixIcon: const Icon(Icons.person_rounded),
//         //             border: OutlineInputBorder(
//         //               borderSide: const BorderSide(),
//         //               borderRadius: BorderRadius.circular(20),
//         //             )))),
//         Container(
//           padding:
//               const EdgeInsets.only(top: 10, right: 35, left: 35, bottom: 50),
//           child: TextField(
//               decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white70,
//                   hintText: 'Company',
//                   prefixIcon: const Icon(Icons.work_rounded),
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(),
//                     borderRadius: BorderRadius.circular(20),
//                   ))),
//         ),
//         SizedBox(
//           height: 50,
//           width: 160,
//           child: ElevatedButton(
//               onPressed: () {},
//               child: const Text('Continue',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   side: const BorderSide(color: Colors.lightBlue),
//                 )),
//               )),
//         )
//       ]),
//     );
//   }
// }



// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           TextField(
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 filled: true,
//                 hintStyle: TextStyle(color: Colors.grey[800]),
//                 hintText: "Type in your text",
//                 fillColor: Colors.white70),
//           )
//         ],
//       ),
//     );
//   }
// }
