import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//import 'src/authentication.dart';
//import 'src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/mainpages/signupPage/signup.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
          shrinkWrap: true,
          // resizeToAvoidBottomInset : false,
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //Orange Guy GIF
            Container(
                padding: const EdgeInsets.all(10),
                child: Lottie.asset(
                  "assets/images/orange-coder.json",
                  repeat: true,
                  // animate: true,
                  fit: BoxFit.fitWidth,
                )),
            //Login Text
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(30, 30, 0, 20),
              child: const Text(
                "Login",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            //Email Field
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                // scrollPadding: EdgeInsets.only(bottom: 40),
                decoration: const InputDecoration(
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
            //Password Field
            Container(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
              child: TextField(
                controller: passwordController,
                //scrollPadding: EdgeInsets.only(bottom: 40),
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    // suffixIcon: Icon(
                    //  Icons.error,
                    // ),
                    labelText: "Password"),
                obscureText: true,
              ),
            ),
            //Login Button
            Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () async {
                  User? user = await signInUsingEmailPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    context: context,
                  );
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
            //bottom text
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: const Text(
                "Or, log in with...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            //Google Button
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //const Spacer(flex: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: MediaQuery.of(context).size.height / 13,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
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
                  const SizedBox(width: 30),
                  // const Spacer(flex: ),
                  //Apple Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: MediaQuery.of(context).size.height / 13,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
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
                  //const Spacer(flex: 4),
                ],
              ),
              //Register Text and Button
            ),
            // const Spacer(flex: 2),
            Container(
              padding: const EdgeInsets.all(10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  const TextSpan(
                    text: "New to Touchbase? ",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignUp()));
                        }),
                ]),
              ),
            ),
           // const Spacer(flex: 1),
          ],
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
  return MaterialColor(color.value, swatch);
}
