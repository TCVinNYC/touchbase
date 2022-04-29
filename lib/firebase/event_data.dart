import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_connect/mainpages/eventsPage/events_page.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
var today = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

Future<String> uploadEvent(
  String sessionTitle,
  DateTime time,
  String description,
  String locationName,
  String locationAddress,
  String price,
  bool paid,
  String category,
  bool age,
  List<String> host,
  File image,
) async {
  CollectionReference ref = FirebaseFirestore.instance.collection('events');
  String docID = FirebaseFirestore.instance.collection('events').doc().id;
  String url = await uploadImage(image, "events");
  if (url != "error") {
    await ref.doc(docID).set({
      'id': docID,
      'sessionTitle': sessionTitle,
      'time': time,
      'imageURL': url,
      'description': description,
      'locationName': locationName,
      'locationAddress': locationAddress,
      'price': price,
      'paid': paid,
      'category': category,
      'age': age,
      'host': host,
    });
    print("done");
    return "done";
  } else {
    print("broke");
    return ("Some error occured, please try again!");
  }
}

Future<String> uploadImage(File file, String baseFolder) async {
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final fileName = basename(file.path);
  final destination = '$baseFolder/$userID/$fileName';

  try {
    final Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(file);
    String url = await ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    print(e.stackTrace);
    return ("error");
  }
}
