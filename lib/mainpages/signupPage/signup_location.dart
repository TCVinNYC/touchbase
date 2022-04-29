import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// class SignUpLocation extends StatelessWidget {
//   const SignUpLocation({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: LocationBody(),
//     );
//   }
// }

// class LocationBackground extends StatelessWidget {
//   final Widget child;
//   const LocationBackground({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//         height: size.height,
//         width: size.width,
//         child: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             Positioned(
//               top: -80,
//               right: -50,
//               child: Image.asset(
//                 "assets/images/signup_bg2.png",
//                 scale: 1.8,
//               ),
//             ),
//             Positioned(
//               top: 70,
//               left: -140,
//               child: Image.asset(
//                 "assets/images/signup_bg3.png",
//                 scale: 1.7,
//               ),
//             ),
//             child,
//           ],
//         ));
//   }
// }

class SignUpLocation extends StatelessWidget {
  const SignUpLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 50),
                width: 250,
                height: 250,
                // padding: const EdgeInsets.only(bottom: 50),
                child: Lottie.asset('assets/images/location.json'),
              ),
              // const Padding(padding: EdgeInsets.only(top: 280)),
              const Text('Would you like to enable location?'),
            ])));
  }
}
