import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lets_connect/login_page.dart';
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
  } on FirebaseAuthException catch (e) {
    print(e);
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

Future<UserCredential> signInWithApple() async {
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

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
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
      style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}

Future resetPassword(String email, context) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password Reset Email Sent!')));
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.message.toString())));
  }
}

Future<User?> refreshUser(User user) async {
  await user.reload();
  User? refreshedUser = auth.currentUser;

  return refreshedUser;
}
