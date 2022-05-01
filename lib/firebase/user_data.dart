import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/firebase/event_data.dart';

Future<String> uploadUserData(
  final String prounouns,
  final String title,
  final String company,
  final String aboutMe,
  final Image profilePic,
  final List<dynamic> eventIDs,
  final List<dynamic> postIDs,
  final List<dynamic> connectionIDs,
  File file,
) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userID = FirebaseAuth.instance.currentUser!.uid;
  String imageurl = await uploadImage(file, 'users');
  if (imageurl != 'error') {
    await firestore.collection('users').doc(userID).set({
      'id': userID,
      'pronouns': prounouns,
      'title': title,
      'imageURL': imageurl,
      'company': company,
      'aboutMe': aboutMe,
      'eventIDs': eventIDs,
      'connectionIDs': connectionIDs,
      'postIDs': postIDs,
    });
    return 'done';
  } else {
    return 'Some error occured, please try again!';
  }
  // final Stream<DocumentSnapshot<Map<String, dynamic>>> userData =
  //     firestore.collection('users').doc(userID).snapshots();
}
