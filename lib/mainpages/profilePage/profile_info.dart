import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/profilePage/profile_info_card.dart';
import 'package:lets_connect/widgets/image_widget.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  

  @override
  Widget build(BuildContext context) {
     final user = UserPreferences.getUser();
    return SizedBox(
      height: 330,
      width: MediaQuery.of(context).size.width,
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
                  //Image( image: user.profilePic!.image,),
                  // CircleAvatar(
                  //   backgroundImage: Image.network(user.profilePic.toString()),
                  //   radius: 55,
                  // ),
                  //ImageWidget(circular: true, width: 175, height: 175, enableEditButton: false, imageAsset: user.profilePic!.image),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        //NAME
                        //change how to get name
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            //'Stevenson Chittumuri',
                            user.name,
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //PRONOUNS
                        //change how to get pronouns
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            //'He/Him',
                            user.prounouns,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // TITLE
                        //change how to get info
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Text(
                            //'ProfessionalCrastinator',
                            user.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Frutiger',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //COMPANY
                        //change how to get info
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            //'New York Institute of Tech',
                            user.company,
                            style: const TextStyle(
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
                    //'pretend i wrote something really intriguing about myself. i like steven universe and ice cream. i have a very lovely gf :)',
                    user.aboutMe,
                    style: const TextStyle(
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
