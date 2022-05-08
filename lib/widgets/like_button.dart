import 'package:flutter/material.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  final String postID;
  int likeCount;
  bool isLiked;
  LikeButtonWidget(
      {Key? key,
      required this.postID,
      required this.likeCount,
      required this.isLiked});
  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    const double size = 17;
    return LikeButton(
        size: size,
        isLiked: widget.isLiked,
        likeCount: widget.likeCount,
        likeBuilder: (isLiked) {
          final color = isLiked ? Colors.amber : Colors.grey;
          return Icon(Icons.thumb_up_alt_rounded, color: color, size: size);
        },
        likeCountPadding: const EdgeInsets.only(left: 5, bottom: 1),
        countBuilder: (count, isLiked, text) {
          final color = isLiked ? Colors.black : Colors.grey;
          return Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
        },
        onTap: (isLiked) async {
          widget.isLiked = !isLiked;
          widget.likeCount += widget.isLiked ? 1 : -1;
          //update server
          if (widget.isLiked) {
            await FireMethods().updateLikeList(widget.postID, true);
            await FireMethods().updateMyLikeList(widget.postID, true);
          } else {
            await FireMethods().updateLikeList(widget.postID, false);
            await FireMethods().updateMyLikeList(widget.postID, false);
          }
          return !isLiked;
        });
  }
}
