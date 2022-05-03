import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class Event {
  final String documentID;
  final String sessionTitle;
  final DateTime time;
  final Image image;
  final String description;
  final String locationName;
  final String locationAddress;
  final bool paid;
  final String price;
  final String category;
  final bool age;
  final List<dynamic> host;
  final List<dynamic> attendees;

  Event(
      {required this.price,
      required this.documentID,
      required this.paid,
      required this.attendees,
      required this.age,
      required this.description,
      required this.time,
      required this.sessionTitle,
      required this.host,
      required this.image,
      required this.locationName,
      required this.locationAddress,
      required this.category});

//info for uploading event
  Map<String, Object?> toJson() {
    return {
      'id': documentID,
      'sessionTitle': sessionTitle,
      'time': time,
      'imageURL': image,
      'description': description,
      'locationName': locationName,
      'locationAddress': locationAddress,
      'price': price,
      'paid': paid,
      'category': category,
      'age': age,
      'host': host,
    };
  }

//info for reading event
  Event.fromJson(Map<String, Object?> json)
      : this(
          documentID: json['id']! as String,
          sessionTitle: json['sessionTitle']! as String,
          time: (json['time']! as Timestamp).toDate(),
          image: Image.network(json['imageURL']! as String),
          description: json['description']! as String,
          locationName: json['locationName']! as String,
          locationAddress: json['locationAddress']! as String,
          price: json['price']! as String,
          paid: json['paid']! as bool,
          category: json['category']! as String,
          age: json['age']! as bool,
          host: json['host']! as List<dynamic>,
          attendees: json['attendees'] != null
              ? json['attendees'] as List<dynamic>
              : <dynamic>[],
        );
}
