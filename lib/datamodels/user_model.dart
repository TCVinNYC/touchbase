class UserData {
  final String userID;
  final String name;
  final String prounouns;
  final String title;
  final String company;
  final String aboutMe;
  final String profilePic;
  final List<dynamic> eventIDs;
  final List<dynamic> postIDs;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> likedPosts;

  const UserData(
      {required this.name,
      required this.userID,
      required this.prounouns,
      required this.title,
      required this.company,
      required this.aboutMe,
      required this.profilePic,
      required this.eventIDs,
      required this.postIDs,
      required this.followers,
      required this.following,
      required this.likedPosts});

  UserData copy(
          {String? userID,
          String? name,
          String? prounouns,
          String? title,
          String? company,
          String? aboutMe,
          String? profilePic,
          List<dynamic>? eventIDs,
          List<dynamic>? postIDs,
          List<dynamic>? following,
          List<dynamic>? followers,
          List<dynamic>? likedPosts}) =>
      UserData(
          userID: userID ?? this.userID,
          name: name ?? this.name,
          prounouns: prounouns ?? this.prounouns,
          title: title ?? this.title,
          company: company ?? this.company,
          aboutMe: aboutMe ?? this.aboutMe,
          profilePic: profilePic ?? this.profilePic,
          eventIDs: eventIDs ?? this.eventIDs,
          postIDs: postIDs ?? this.postIDs,
          followers: followers ?? this.followers,
          following: following ?? this.following,
          likedPosts: likedPosts ?? this.likedPosts);

//info for uploading user
  Map<String, dynamic> toJson() {
    return {
      'id': userID,
      'name': name,
      'pronouns': prounouns,
      'title': title,
      'imageURL': profilePic,
      'company': company,
      'aboutMe': aboutMe,
      'eventIDs': eventIDs,
      'followers': followers,
      'following': following,
      'likedPosts': likedPosts,
      'postIDs': postIDs,
    };
  }

//info for reading user
  static UserData fromJson(Map<String, dynamic>? json) {
      return UserData(
          userID: json!['id'],
          name: json['name'],
          prounouns: json['pronouns'],
          title: json['title'],
          profilePic: json['imageURL'],
          aboutMe: json['aboutMe'],
          company: json['company'],
          postIDs: json['postIDs'],
          eventIDs: json['eventIDs'],
          following: json['following'],
          followers: json['followers'],
          likedPosts: json['likedPosts']);
  }
}
