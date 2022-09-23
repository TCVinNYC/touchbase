import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

FirebaseAuth auth = FirebaseAuth.instance;
User? user;

Future<User?> signInUsingEmailPassword({
  required String email,
  required String password,
  required context,
}) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    user = auth.currentUser;

    //UserPreferences.setCred(userCredential);
  } on FirebaseAuthException catch (e) {
    if (email == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter email first! Please try again!')));
    } else if (password == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cannot have an empty password! Please try again!')));
    } else if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong Email. Please try again!')));
    } else if (e.code == 'account-exists-with-different-credential') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try Sign In with Google or Apple')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong Password. Please try again!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  return user;
}

Future<User?> registerUsingEmailPassword({
  required context,
  required String name,
  required String email,
  required String password,
}) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //UserPreferences.setCred(userCredential);
    user = userCredential.user;
    await user!.updateDisplayName(name);
    await user?.reload();
    user = auth.currentUser;
  } on FirebaseAuthException catch (e) {
    if (email == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter email first! Please try again!')));
    } else if (password == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cannot have an empty password! Please try again!')));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.')));
    } else if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')));
    } else if (e.code == 'account-exists-with-different-credential') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try Sign In with Google or Apple')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  return user;
}

Future<String> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  try {
    // Attempt to sign in the user in with Google
    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    //UserPreferences.setCred(authResult);
  } on FirebaseAuthException catch (e) {
    debugPrint(e.toString());
  }
  // Once signed in, return the UserCredential
  return 'signInWithGoogle succeeded: $user';
}

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<UserCredential> signInWithApple(context) async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // final fixAppleName = [
  //   appleCredential.givenName ?? '',
  //   appleCredential.familyName ?? ''
  // ].join(' '.trim());

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  UserCredential userC = await FirebaseAuth.instance
      .signInWithCredential(oauthCredential)
      .whenComplete(() {
    if (FirebaseAuth.instance.currentUser!.displayName!.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please wait...")));
    }
  });
  //UserPreferences.setCred(userC);
  return userC;
}

Future<void> signOutFromGoogle() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut();
  await _auth.signOut();
}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}

Future<String> resetPassword(String email) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
    return 'done';
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
  }
}

Future<User?> refreshUser(User user) async {
  await user.reload();
  User? refreshedUser = auth.currentUser;

  return refreshedUser;
}

Future<String> deleteAllData() async {
  final instance = FirebaseFirestore.instance;
  UserData currentUser = UserPreferences.getUser();
  var users = instance.collection('users');

  debugPrint("deleting user");
  //checks if my user has any events associated otherwise skip
  if (currentUser.eventIDs.isNotEmpty) {
    debugPrint("deleting eventIDs");
    var events = instance.collection('events');
    //remove myself from all attendeed events
    var eventsAttendeesCollection = await events
        .where('attendees', arrayContains: currentUser.userID)
        .get();
    for (var event in eventsAttendeesCollection.docs) {
      debugPrint("@ attendee list");
      event.reference.update({
        "attendees": FieldValue.arrayRemove([currentUser.userID])
      });
    }

    //delete my events
    var myEventsCollection =
        await events.where('host', arrayContains: currentUser.userID).get();
    for (var event in myEventsCollection.docs) {
      debugPrint("deleting my events");
      event.reference.delete();
    }

    //remove traces of my events from other users
    var userAttendeesCollection =
        await users.where('eventIDs', whereIn: currentUser.eventIDs).get();
    for (var user in userAttendeesCollection.docs) {
      debugPrint("remove my events from others");
      user.reference.update({
        "eventIDs": FieldValue.arrayRemove([currentUser.eventIDs])
      });
    }
  }

  //checks if my user has any posts associated otherwise skip
  if (currentUser.postIDs.isNotEmpty || currentUser.likedPosts.isNotEmpty) {
    debugPrint("removing posts");
    var posts = instance.collection('posts');
    if (currentUser.postIDs.isNotEmpty) {
      //delete all my posts
      var myPostCollection =
          await posts.where('id', whereIn: currentUser.postIDs).get();
      for (var posts in myPostCollection.docs) {
        posts.reference.delete();
      }
    }

    debugPrint("removing what i liked");
    //remove myself from any posts i liked
    if (currentUser.likedPosts.isNotEmpty) {
      var eventsAttendeesCollection =
          await posts.where('likes', arrayContains: currentUser.userID).get();
      for (var posts in eventsAttendeesCollection.docs) {
        posts.reference.update({
          "likes": FieldValue.arrayRemove([currentUser.userID])
        });
      }
    }
  }

  //checks if my user has any followers/following associated otherwise skip
  if (currentUser.followers.isNotEmpty || currentUser.following.isNotEmpty) {
    //remove any traces of myself on other users following list
    if (currentUser.followers.isNotEmpty) {
      var myfollowersCollection = await users
          .where('following', arrayContains: currentUser.userID)
          .get();
      for (var user in myfollowersCollection.docs) {
        user.reference.update({
          "following": FieldValue.arrayRemove([currentUser.userID])
        });
      }
    }

    debugPrint("removing followers list i liked");
    //remove any traces of myself on other users followers list
    if (currentUser.following.isNotEmpty) {
      var myfollowingCollection = await users
          .where('followers', arrayContains: currentUser.userID)
          .get();
      for (var user in myfollowingCollection.docs) {
        user.reference.update({
          "followers": FieldValue.arrayRemove([currentUser.userID])
        });
      }
    }
  }

  // final Reference ref = FirebaseStorage.instance.ref();
  // //remove any traces of myself in all storage units
  // if (currentUser.eventIDs.isNotEmpty) {
  //   String userID = currentUser.userID;
  //   final eventsFolder = 'events/$userID';
  //   try {
  //     await ref.child(eventsFolder).delete();
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code);
  //   }
  // }
  // if (currentUser.postIDs.isNotEmpty) {
  //   String userID = currentUser.userID;
  //   final eventsFolder = 'posts/$userID';
  //   try {
  //     await ref.child(eventsFolder).delete();
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code);
  //   }
  // }
  // if (currentUser.eventIDs.isNotEmpty) {
  //   String userID = currentUser.userID;
  //   final eventsFolder = 'users/$userID';
  //   try {
  //     await ref.child(eventsFolder).delete();
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.code);
  //   }
  // }

  debugPrint("completed deleting all references, now the big finale");
  users.doc(currentUser.userID).delete();
  User firebaseUser = FirebaseAuth.instance.currentUser!;
  await firebaseUser.reload();
  await firebaseUser.delete();
  await signOutFromGoogle();
  UserPreferences.resetUser();

  return ("done");
}

Future<String> deleteMyPost(String userID, String postID) async {
  try {
    await FirebaseFirestore.instance.collection('posts').doc(postID).delete();
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      "postIDs": FieldValue.arrayRemove([postID])
    });
    return "done";
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
  }
}

Future<String> deleteMyEvent(String userID, String eventID) async {
  try {
    var instance = FirebaseFirestore.instance;
    debugPrint("deleting event");

    var events = instance.collection('events');

    //delete my events
    await events.doc(eventID).delete();

    //remove traces of my events from other users
    var userAttendeesCollection = await instance
        .collection('users')
        .where('eventIDs', arrayContains: eventID)
        .get();
    for (var user in userAttendeesCollection.docs) {
      debugPrint("remove my events for others");
      user.reference.update({
        "eventIDs": FieldValue.arrayRemove([eventID])
      });
    }

    return "done";
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
  }

  // try {
  //   await FirebaseFirestore.instance.collection('posts').doc(postID).delete();
  //   await FirebaseFirestore.instance.collection('users').doc(userID).update({
  //     "postIDs": FieldValue.arrayRemove([postID])
  //   });

  // } on FirebaseAuthException catch (e) {

  // }
}
