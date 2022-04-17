import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: -100,
            left: -70,
            child: Image.asset(
              "assets/images/signup_bg1.png",
              scale: 1.2,
            ),
          ),
          Positioned(
            top: -80,
            right: -50,
            child: Image.asset(
              "assets/images/signup_bg2.png",
              scale: 1.8,
            ),
          ),
          Positioned(
            top: 70,
            left: -140,
            child: Image.asset(
              "assets/images/signup_bg3.png",
              scale: 1.7,
            ),
          ),
          Positioned(
            bottom: 230,
            right: -120,
            child: Image.asset(
              "assets/images/signup_bg4.png",
              scale: 1.9,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
