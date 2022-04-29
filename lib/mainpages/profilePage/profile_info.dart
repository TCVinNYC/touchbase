import 'package:flutter/material.dart';
import 'package:lets_connect/mainpages/profilePage/profile_info_card.dart';
import 'package:lets_connect/mainpages/profilePage/account_info.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      width: MediaQuery.of(context).size.width,
      // decoration: const BoxDecoration(color: Colors.grey),
      child: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 290,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage('assets/images/profile_bg.jpg'),
                // ),
                color: Colors.orangeAccent,
                // color: Color.fromARGB(255, 255, 237, 210),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  //PROFILE PIC
                  //change how to get profile pic
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/94/25/93/9425933cef85981844778fe55327f5da.jpg'),
                    radius: 55,
                  ),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                        //NAME
                        //change how to get name
                        Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            'Stevenson Chittumuri',
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //PRONOUNS
                        //change how to get pronouns
                        Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            'He/Him',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // TITLE
                        //change how to get info
                        Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            'ProfessionalCrastinator',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //COMPANY
                        //change how to get info
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'New York Institute of Tech',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]))
                ]),
                //ABOUT ME
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    // aboutMe,
                    'pretend i wrote something really intriguing about myself. i like steven universe and ice cream. i have a very lovely gf :)',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Frutiger',
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontSize: 16),
                  ),
                ),
              ],
            )),
        const Positioned(bottom: 0, right: 0, left: 0, child: ProfileInfoCard())
      ]),
    );
  }
}
