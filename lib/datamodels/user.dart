import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class User {
  final String userID;
  final String prounouns;
  final String title;
  final String company;
  final String aboutMe;
  final Image profilePic;
  final List<dynamic> eventIDs;
  final List<dynamic> postIDs;
  final List<dynamic> connectionIDs;

  User({
    required this.userID,
    required this.prounouns,
    required this.title,
    required this.company,
    required this.aboutMe,
    required this.profilePic,
    required this.eventIDs,
    required this.postIDs,
    required this.connectionIDs,
  });

//info for uploading event
  Map<String, Object?> toJson() {
    return {
      'id': userID,
      'pronouns': prounouns,
      'title': title,
      'imageURL': profilePic,
      'company': company,
      'aboutMe': aboutMe,
      'eventIDs': eventIDs,
      'connectionIDs': connectionIDs,
      'postIDs': postIDs,
    };
  }

//info for reading event
  User.fromJson(Map<String, Object?> json)
      : this(
          userID: json['id']! as String,
          prounouns: json['pronouns']! as String,
          title: json['title']! as String,
          profilePic: Image.network(json['imageURL']! as String),
          aboutMe: json['aboutMe']! as String,
          company: json['company']! as String,
          postIDs: json['postIDs']! as List<dynamic>,
          eventIDs: json['eventIDs']! as List<dynamic>,
          connectionIDs: json['connectionIDs']! as List<dynamic>,
        );
}
