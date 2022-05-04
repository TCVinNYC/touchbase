import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:path/path.dart';

class FireMethods {
  // FireMethods();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference refEvents = firestore.collection('events');
  static var fireAuth = FirebaseAuth.instance;
  static var today = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

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
    List<dynamic> host,
    File? file,
  ) async {
    String docID = refEvents.doc().id;
    
    String url = await uploadImage(file!, "events");
    if (url != "error") {
      await refEvents.doc(docID).set({
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
        'attendees': [host[3]]
      });
      updateUserEventCount(docID, true);
      return "done";
    } else {
      return ("Some error occured, please try again!");
    }
  }

  Future<String> uploadUserData(
    String? prounouns,
    String name,
    String title,
    String company,
    String aboutMe,
    List<dynamic>? eventIDs,
    List<dynamic>? postIDs,
    List<dynamic>? connectionIDs,
    File? file,
  ) async {
    String imageurl = await uploadImage(file!, 'users');
    if (imageurl != 'error') {
      await firestore.collection('users').doc(fireAuth.currentUser!.uid).set({
        'id': fireAuth.currentUser!.uid,
        'name': name,
        'pronouns': prounouns ?? "",
        'title': title,
        'imageURL': imageurl,
        'company': company,
        'aboutMe': aboutMe,
        'eventIDs': eventIDs ?? [],
        'connectionIDs': connectionIDs ?? [],
        'postIDs': postIDs ?? [],
      });
      return 'done';
    } else {
      return 'Some error occured, please try again!';
    }
  }

  Future<UserData?> getUserData(String userID) async {
    var docSnapshot = await firestore.collection('users').doc(userID).get();
    if (docSnapshot.exists) {
      return UserData.fromJson(docSnapshot.data());
    }
    return null;
  }



  Future<String> updateUserEventCount(String eventID, bool addToList) {
    return firestore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .update({
          'eventIDs': addToList == true
              ? FieldValue.arrayUnion([eventID])
              : FieldValue.arrayRemove([eventID])
        })
        .then((value) => addToList == true ? "Event Added" : "Event Removed")
        .catchError((error) => "Failed to update User Event: $error");
  }

  Future<String> updateAttendeeList(String eventID, bool addToList) {
    return firestore
        .collection('events')
        .doc(eventID)
        .update({
          'attendees': addToList == true
              ? FieldValue.arrayUnion([fireAuth.currentUser!.uid])
              : FieldValue.arrayRemove([fireAuth.currentUser!.uid])
        })
        .then((value) =>
            addToList == true ? "Added To Event" : "Removed From Event")
        .catchError((error) => "Failed to update User Event: $error");
  }

  // Stream<UserData> getUserData(String userID) => FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(userID)
  //     .snapshots()
  //     .map((user) => UserData.fromJson(user.data() as Map<String, dynamic>));

  // .snapshots()
  // .map((snapshot) =>
  //     snapshot() => UserData.fromJson(documentSnapshot.data);

  // UserData? getUserData(String userID) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userID)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       //User currentUser;
  //       //Map<String, dynamic> currentUser = documentSnapshot.data()! as Map<String, dynamic>;
  //       //return currentUser;
  //       //currentUser = jsonDecode(documentSnapshot);
  //       print('Document data: ${documentSnapshot.data()}');

  //       return UserData.fromJson(documentSnapshot.data as Map<String, dynamic>);
  //       // User user
  //     } else {
  //       print('Document does not exist on the database');
  //       return null;
  //     }
  //   });
  //   return null;
  // }

  Future<String> uploadImage(File file, String baseFolder) async {
    final fileName = basename(file.path);
    var uid = fireAuth.currentUser!.uid;
    final destination = '$baseFolder/$uid/$fileName';

    try {
      final Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(file);
      String url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print(e.code);
      return ("error");
    }
  }
}
