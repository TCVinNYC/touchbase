import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/signupPage/background.dart';

// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
// //  final String title;

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Container(
//               width: MediaQuery.of(context).size.width,
//               padding: const EdgeInsets.all(20),
//               child: Image.asset("assets/images/signup_bottom.png")
//               // const Text(
//               //   "hello",
//               //   textAlign: TextAlign.left,
//               //   style: TextStyle(
//               //     fontWeight: FontWeight.bold,
//               //     fontSize: 35,
//               //   ),
//               // ),
//               ),
//         ),
//       ),
//     );
//   }
// }

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
              onPressed: () {},
              child: const Text('Continue',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.lightBlue),
                )),
              )),
        )
      ]),
    );
  }
}



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
