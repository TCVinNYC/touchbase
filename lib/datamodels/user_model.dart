import 'package:flutter/material.dart';

class UserData {
  final String userID;
  final String name;
  final String prounouns;
  final String title;
  final String company;
  final String aboutMe;
  final Image profilePic;
  final List<dynamic> eventIDs;
  final List<dynamic> postIDs;
  final List<dynamic> connectionIDs;

  UserData({
    required this.name,
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
      'name' : name,
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
  UserData.fromJson(Map<String, Object?> json)
      : this(
          userID: json['id']! as String,
          name: json['name']! as String,
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
