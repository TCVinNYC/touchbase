import 'package:flutter/material.dart';

class AboutMeCard extends StatelessWidget {
  const AboutMeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 230,
      // alignment: Alignment.center,
      // decoration: const BoxDecoration(color: Colors.grey),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'About Me',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            //obviously change how to get these texts
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                'Title',
                style: TextStyle(fontSize: 16, fontFamily: 'Frutiger'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Company',
                style: TextStyle(fontSize: 16, fontFamily: 'Frutiger'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'i ran out of creativity pretend i wrote something really intriguing about myself here and other stuff',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Frutiger', height: 1.2),
              ),
            ),
            //account settings and details card
          ],
        ),
      ),
    );
  }
}
