import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  return user;
}

Future<User?> refreshUser(User user) async {
  await user.reload();
  User? refreshedUser = auth.currentUser;

  return refreshedUser;
}
