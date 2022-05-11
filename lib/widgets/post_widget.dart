import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/post_model.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/feedPage/feed_page.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/widgets/icon_button.dart';
import 'package:lets_connect/widgets/showHost.dart';
import 'package:intl/intl.dart';

class FeedPost extends StatefulWidget {
  UserData user;
  final Post post;
  FeedPost({Key? key, required this.post, required this.user})
      : super(key: key);
  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  blurRadius: 2.0,
                  offset: const Offset(2.0, 3.0),
                  spreadRadius: .5)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showHost(
                    host: widget.post.poster,
                    width: 50,
                    height: 50,
                    showName: true,
                  ),
                  widget.post.poster[3] == UserPreferences.getUser().userID
                      ? GestureDetector(
                          onTap: () {
                            showAlertDialog(context, widget.post.documentID);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 17,
                            color: Colors.redAccent.shade200,
                          ),
                        )
                      : Container(),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 3)),
              const Divider(thickness: 1),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              widget.post.postText != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(widget.post.postText!,
                          style: const TextStyle(
                            fontFamily: 'Frutiger',
                            fontSize: 15,
                            height: 1.2,
                          )),
                    )
                  : Container(),
              if (widget.post.image != null)
                Image(image: NetworkImage(widget.post.image!))
              else
                Container(),
              // const Padding(
              //   padding: EdgeInsets.only(bottom: 10),
              // ),
              //const Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 3, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('MMMM dd, yyyy @ h:mm a')
                          .format(widget.post.timeOfPost),
                      textScaleFactor: 0.85,
                      style: const TextStyle(
                          fontFamily: 'Frutiger',
                          fontSize: 15,
                          color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Coming Soon'),
                              action: SnackBarAction(
                                label: 'Dismiss',
                                textColor: Colors.amber,
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            ));
                          },
                          child: const Icon(
                            Icons.comment,
                            size: 17,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        LikeButtonWidget(
                          isLiked: widget.user.likedPosts
                              .contains(widget.post.documentID),
                          likeCount: widget.post.likes.length,
                          id: widget.post.documentID,
                          fontSize: 16,
                          iconSize: 17,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

showAlertDialog(BuildContext context, String postID) {
  // Create button
  Widget okButton = TextButton.icon(
      onPressed: () async {
        String result =
            await deleteMyPost(UserPreferences.getUser().userID, postID);
        if (result == "done") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Post Deleted')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (Route<dynamic> route) => false,
        );
      },
      icon: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.red,
      ),
      label: const Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ));

  Widget cancel = TextButton.icon(
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
      },
      icon: const Icon(Icons.cancel),
      label: const Text("Cancel"));

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Post Deletion"),
    content: const Text("Are you sure you want to delete your post?"),
    actions: [okButton, cancel],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
