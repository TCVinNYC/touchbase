import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String documentID;
  final DateTime timeOfPost;
  final String? image;
  final String? postText;
  final List<dynamic> poster;
  final List<dynamic> likes;

  Post({
    required this.documentID,
    required this.timeOfPost,
    required this.poster,
    required this.likes,
    this.image,
    this.postText,
  });

//info for post event
  Map<String, Object?> toJson() {
    return {
      'id': documentID,
      'timeOfPost': timeOfPost,
      'image': image ?? '',
      'postText': postText ?? '',
      'poster': poster,
      'likers': likes,
    };
  }

//info for reading post
  Post.fromJson(Map<String, Object?> json)
      : this(
          documentID: json['id'] as String,
          timeOfPost: (json['timeOfPost'] as Timestamp).toDate(),
          image: json['image'] != null ?  json['image'] as String : null,
          postText: json['postText'] != null ?  json['postText'] as String : null,
          poster: json['poster'] as List<dynamic>,
          likes: json['likes'] != null
              ? json['likes'] as List<dynamic>
              : <dynamic>[],
        );
}
          // image: json['image'] != null ? json['image'] as String: '',
          // postText: json['postText'] != null ? json['postText'] as String: '',