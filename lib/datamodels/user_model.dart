import 'package:flutter/material.dart';

class UserData {
  final String userID;
  final String name;
  final String prounouns;
  final String title;
  final String company;
  final String aboutMe;
  final Image? profilePic;
  final String? profilePicLinkOnly;
  final List<dynamic> eventIDs;
  final List<dynamic> postIDs;
  final List<dynamic> connectionIDs;

  const UserData({
     this.profilePicLinkOnly,
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

  UserData copy(
          {String? userID,
          String? name,
          String? prounouns,
          String? title,
          String? company,
          String? aboutMe,
          Image? profilePic,
          String? profilePicLinkOnly,
          List<dynamic>? eventIDs,
          List<dynamic>? postIDs,
          List<dynamic>? connectionIDs}) =>
      UserData(
          userID: userID ?? this.userID,
          name: name ?? this.name,
          prounouns: prounouns ?? this.prounouns,
          title: title ?? this.title,
          company: company ?? this.company,
          aboutMe: aboutMe ?? this.aboutMe,
          profilePic: profilePic ?? this.profilePic,
          profilePicLinkOnly: profilePicLinkOnly ?? this.profilePicLinkOnly,
          eventIDs: eventIDs ?? this.eventIDs,
          postIDs: postIDs ?? this.postIDs,
          connectionIDs: connectionIDs ?? this.connectionIDs);

//info for uploading user
  Map<String, dynamic> toJson() {
  // final bytes = Io.File(profilePicLinkOnly).readAsBytesSync();
  // String img64 = base64Encode(bytes);
  // print("DONE CONVERTING" +img64);
    return {
      'id': userID,
      'name': name,
      'pronouns': prounouns,
      'title': title,
      'imageURL': profilePic.toString(),
      //'imageURLString': profilePic.toString(),
      'company': company,
      'aboutMe': aboutMe,
      'eventIDs': eventIDs,
      'connectionIDs': connectionIDs,
      'postIDs': postIDs,
    };
  }

//info for reading user
  static UserData fromJson(Map<String, dynamic>? json) =>
      UserData(
          userID : json!['id'] as String,
          name : json['name'] as String,
          prounouns: json['pronouns'] as String,
          title: json['title'] as String,
          profilePic: Image.network(json['imageURL']),
          //profilePic: Image.network(json['imageURL'] as String),
          //profilePicLinkOnly: json['imageURLString'] as String,
          aboutMe: json['aboutMe'] as String,
          company: json['company'] as String,
          postIDs: json['postIDs'] as List<dynamic>,
          eventIDs: json['eventIDs'] as List<dynamic>,
          connectionIDs: json['connectionIDs'] as List<dynamic>,
        );

}
