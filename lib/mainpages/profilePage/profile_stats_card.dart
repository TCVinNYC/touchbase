import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/user_model.dart';

class ProfileStatsCard extends StatelessWidget {
  UserData userdata;
  ProfileStatsCard({Key? key, required this.userdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 60),
        height: 90,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Connections',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.connectionIDs.length.toString(),
                      //'16',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.postIDs.length.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Events',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //find a way to get connections amount
                    Text(
                      userdata.eventIDs.length.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
