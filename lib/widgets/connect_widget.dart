// Ameer Ahmed Connect widget

import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/mainpages/profilePage/profile_info.dart';
import 'package:lets_connect/widgets/icon_button.dart';

// ignore: must_be_immutable
class ConnectWidget extends StatefulWidget {
  UserData myUser;
  UserData user;
  ConnectWidget({Key? key, required this.user, required this.myUser})
      : super(key: key);

  @override
  State<ConnectWidget> createState() => _ConnectWidgetState();
}

class _ConnectWidgetState extends State<ConnectWidget> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.orangeAccent,
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 0.5,
                        minChildSize: 0.5,
                        maxChildSize: 0.9,
                        snap: true,
                        snapSizes: const [0.5, 0.9],
                        builder: (_, controller) {
                          return Scaffold(
                            appBar: AppBar(
                              backgroundColor: Colors.orange,
                            ),
                            body: SingleChildScrollView(
                              controller: controller,
                              child: Column(
                                children: <Widget>[
                                  ProfileInfo(userData: widget.user),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(widget.user.profilePic),
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Row(
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                widget.user.prounouns.isNotEmpty
                    ? Text(
                        " (" + widget.user.prounouns + ")",
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontSize: 13),
                      )
                    : Container(),
              ],
            ),
            trailing: SizedBox(
              width: 35,
              child: LikeButtonWidget(
                isFollowButton: true,
                iconSize: 27,
                enableText: false,
                id: widget.user.userID,
                isLiked: widget.myUser.following.contains(widget.user.userID),
              ),
            ),
            subtitle: Text(
              widget.user.title + "\n" + widget.user.company,
              style: const TextStyle(
                  color: Colors.black, fontFamily: 'Quicksand', fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

          // ListTile(
          //   contentPadding: const EdgeInsets.all(10),
          //   title: showHost(
          //     host: [
          //       widget.user.name,
          //       widget.user.title,
          //       widget.user.profilePic,
          //       widget.user.userID
          //     ],
          //     width: 50,
          //     height: 50,
          //     showName: true,
          //   ),
          //   trailing: IconButton(
          //     icon: Icon(iconCheck, color: iconColor),
          //     onPressed: () {
          //       setState(() {
          //         Icon(iconCheck, color: iconColor);
          //         iconCheck = Icons.check_box;
          //         iconColor = Colors.yellow;
          //       });
          //     },
          //   ),
          // ),