import 'dart:convert';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'userSaved';
  static const myNullUser = UserData(
      aboutMe: 'About Me Section',
      company: 'Some Company',
      connectionIDs: [],
      eventIDs: [],
      name: 'John Doe',
      postIDs: [],
      profilePic:
          'https://cdn.sanity.io/images/ay6gmb6r/production/52566e987046623a25e2f40a11fa99bbd9f4d4d2-2240x1260.png',
      prounouns: 'Not/Here',
      title: 'Mr Title',
      userID: '1234567890');

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setUser(UserData user) async {
    final json = jsonEncode(user.toJson());
    await _preferences.setString(_keyUser, json);
    print("saved user");
  }

  static UserData getUser() {
    final json = _preferences.getString(_keyUser);
    print("got saved user");
    return json == null ? myNullUser : UserData.fromJson(jsonDecode(json));
  }

  static resetUser() async {
    _preferences.remove(_keyUser);
    _preferences.clear;
    _preferences.reload;
    print("reset user");
  }
}
