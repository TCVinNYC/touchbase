import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as Io;
import 'dart:convert';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'userSaved';
  static UserData myNullUser = UserData(
    aboutMe: 'About Me Section',
    company: 'Some Company',
    connectionIDs: [],
    eventIDs: [],
    name: 'John Doe',
    postIDs: [],
    profilePic: Image.asset('assetsimages/blank-pfp.png'),
    profilePicLinkOnly: 'google.com',
    prounouns: 'Not/Here',
    title: 'Mr Title',
    userID: '1234567890');

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setUser(UserData user) async {

    final json = jsonEncode(user.toJson());
    print(json);
    await _preferences.setString(_keyUser, json);
    print("saved user");
  }

  static UserData getUser() {
    final json = _preferences.getString(_keyUser);
    print("got saved user");
    print(json);
    print(_keyUser);
    return json == null ? myNullUser : UserData.fromJson(jsonDecode(json));
  }
}
