import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/widgets/connect_widget.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);
  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  List<UserData> _userList = [];
  UserData userData = UserPreferences.getUser();
  List<UserData> temp = [];

  void getPosts() async {
    var userTemp = UserPreferences.getUser();
    if (userTemp.following.isNotEmpty) {
      temp = await FirebaseFirestore.instance
          .collection('users')
          .where('id', whereNotIn: userTemp.following)
          .get()
          .then((value) =>
              value.docs.map((doc) => UserData.fromJson(doc.data())).toList())
          .then((value) =>
              value.where((value) => value.userID != userTemp.userID).toList());
    } else {
      temp = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isNotEqualTo: userTemp.userID)
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => UserData.fromJson(doc.data()))
              .toList());
    }

    setState(() {
      _userList = temp;
      userData = userTemp;
    });
  }

  Future<void> _getData() async {
    setState(() {
      getPosts();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Coming Soon'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    textColor: Colors.amber,
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                ));
              },
              icon: const Icon(Icons.message_rounded),
              color: Colors.black,
            )
          ],
          title: const Text(
            "Let's Connect",
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          )),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: SafeArea(
          top: false,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _userList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ConnectWidget(
                  user: _userList[index],
                  myUser: userData,
                );
              }),
        ),
      ),
    );
  }
}
