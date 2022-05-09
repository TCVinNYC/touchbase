import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  //IconData iconData;
  double iconSize;
  double? fontSize;
  bool? enableText;
  bool? isFollowButton;
  bool? isBookmark;
  final String id;
  int? likeCount;
  bool isLiked;

  LikeButtonWidget({
    Key? key,
    //Key? key,
    required this.id,
    this.enableText,
    //required this.iconData,
    this.fontSize,
    required this.iconSize,
    this.isBookmark,
    this.isFollowButton,
    this.likeCount,
    required this.isLiked,
  }) : super(key: key);
  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    //const double size = 17;
    return LikeButton(
        size: widget.iconSize,
        isLiked: widget.isLiked,
        likeCount: widget.likeCount,
        likeBuilder: (isOn) {
          final color = isOn ? Colors.amber : Colors.grey;
          if (widget.isFollowButton == true) {
            if (widget.id == UserPreferences.getUser().userID) {
              return Icon(Icons.face_rounded,
                  color: Colors.deepOrangeAccent, size: widget.iconSize);
            }
            return Icon(Icons.check_circle,
                color: color, size: widget.iconSize);
          } else if (widget.isBookmark == true) {
            return Icon(Icons.bookmark, color: color, size: widget.iconSize);
          } else {
            return Icon(Icons.thumb_up_alt_rounded,
                color: color, size: widget.iconSize);
          }
        },
        likeCountPadding: const EdgeInsets.only(left: 5, bottom: 1),
        countBuilder: (count, isLiked, text) {
          final color = isLiked ? Colors.black : Colors.grey;
          if (widget.enableText == true) {
            return Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: widget.fontSize,
                //fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            Container();
          }
          return null;
        },
        onTap: (isOn) async {
          widget.isLiked = !isOn;
          if (widget.isFollowButton == true) {
            if (widget.id != UserPreferences.getUser().userID) {
              if (widget.isLiked) {
                await FireMethods().updateFollowing(widget.id, true);
                await FireMethods().updateMyFollowing(widget.id, true);
              } else {
                await FireMethods().updateFollowing(widget.id, false);
                await FireMethods().updateMyFollowing(widget.id, false);
              }
            }
          } else if (widget.isBookmark == true) {
          } else {
            if (widget.likeCount != null) {
              if (widget.isLiked) {
                widget.likeCount = (widget.likeCount! + 1);
              } else {
                widget.likeCount = (widget.likeCount! - 1);
              }
            }
            //widget.likeCount += widget.isLiked ? 1 : -1;
            //update server
            if (widget.isLiked) {
              await FireMethods().updateLikeList(widget.id, true);
              await FireMethods().updateMyLikeList(widget.id, true);
            } else {
              await FireMethods().updateLikeList(widget.id, false);
              await FireMethods().updateMyLikeList(widget.id, false);
            }
          }

          return !isOn;
        });
  }
}
