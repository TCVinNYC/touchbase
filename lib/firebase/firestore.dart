import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:path/path.dart';

class FireMethods {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static var fireAuth = FirebaseAuth.instance;
  static var today = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  Future<String> uploadUserData(
    String? prounouns,
    String name,
    String title,
    String company,
    String aboutMe,
    List<dynamic>? eventIDs,
    List<dynamic>? postIDs,
    List<dynamic>? connectionIDs,
    List<dynamic>? likedPosts,
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
        'likedPosts': likedPosts ?? [],
      });
      UserData? userData = await FireMethods()
          .getUserData(FireMethods.fireAuth.currentUser!.uid);
      UserPreferences.setUser(userData!);
      return 'done';
    } else {
      return 'Some error occured, please try again!';
    }
  }

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
    String docID = firestore.collection('events').doc().id;
    String imageurl = await uploadImage(file!, 'events');

    if (imageurl != "error") {
      await firestore.collection('events').doc(docID).set({
        'id': docID,
        'sessionTitle': sessionTitle,
        'time': time,
        'imageURL': imageurl,
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
      UserData tempUser = UserPreferences.getUser();
      tempUser.eventIDs.add(docID);
      UserPreferences.setUser(tempUser);
      await updateUserEventCount(docID, true);
      return "done";
    } else {
      return ("Some error occured, please try again!");
    }
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

  Future<String> uploadPost(
    DateTime timeOfPost,
    String? postText,
    List<dynamic> poster,
    List<dynamic> likes,
    File? file,
  ) async {
    String docID = firestore.collection('posts').doc().id;
    String? imageurl;
    if (file != null) {
      imageurl = await uploadImage(file, 'posts');
      if (imageurl == "error") {
        return ("Some error occured, please try again!");
      }
    } else {
      imageurl = null;
    }
    await firestore.collection('posts').doc(docID).set({
      'id': docID,
      'timeOfPost': timeOfPost,
      'image': imageurl,
      'postText': postText,
      'poster': poster,
      'likes': likes,
    });
    UserData tempUser = UserPreferences.getUser();
    tempUser.postIDs.add(docID);
    UserPreferences.setUser(tempUser);
    await updateUserPostCount(docID, true);
    return "done";
  }

  Future<String> updateUserPostCount(String postID, bool addToList) {
    return firestore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .update({
          'postIDs': addToList == true
              ? FieldValue.arrayUnion([postID])
              : FieldValue.arrayRemove([postID])
        })
        .then((value) => addToList == true ? "Post Created" : "Post Removed")
        .catchError((error) => "Failed to update User Post: $error");
  }

  Future<String> updateLikeList(String postID, bool addToList) {
    return firestore
        .collection('posts')
        .doc(postID)
        .update({
          'likes': addToList == true
              ? FieldValue.arrayUnion([fireAuth.currentUser!.uid])
              : FieldValue.arrayRemove([fireAuth.currentUser!.uid])
        })
        .then((value) => addToList == true ? "Liked Post" : "Unliked Post")
        .catchError((error) => "Failed to update Post Action: $error");
  }

  Future<String> updateMyLikeList(String postID, bool addToList) {
    UserData tempUser = UserPreferences.getUser();
    addToList
        ? tempUser.likedPosts.add(postID)
        : tempUser.likedPosts.remove(postID);
    UserPreferences.setUser(tempUser);
    return firestore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .update({
          'likedPosts': addToList == true
              ? FieldValue.arrayUnion([postID])
              : FieldValue.arrayRemove([postID])
        })
        .then((value) => addToList == true ? "Liked Post" : "Unliked Post")
        .catchError((error) => "Failed to update Post Action: $error");
  }

  Future<UserData?> getUserData(String userID) async {
    var docSnapshot = await firestore.collection('users').doc(userID).get();
    if (docSnapshot.exists) {
      return UserData.fromJson(docSnapshot.data());
    }
    return null;
  }

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
