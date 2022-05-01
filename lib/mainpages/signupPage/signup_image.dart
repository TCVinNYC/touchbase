import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lottie/lottie.dart';
import 'package:lets_connect/mainpages/profilePage/profile_page.dart';

class SignUpImage extends StatelessWidget {
  const SignUpImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 90),
              width: 280,
              height: 280,
              child: Lottie.asset('assets/images/signup_image.json'),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              margin: const EdgeInsets.only(top: 100, bottom: 50),
              child: const Text(
                // 'Help others recognise you by adding a profile picture.',
                'Enable camera roll to upload pictures in your posts and/or use it to select your profile picture.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MainPage()));
                  },
                  child: const Text(
                    'Enable Camera Roll',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
