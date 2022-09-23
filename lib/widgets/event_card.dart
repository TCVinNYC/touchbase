import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/main.dart';
import 'package:lets_connect/mainpages/eventsPage/view_event.dart';
import 'package:lets_connect/widgets/show_date.dart';
import 'package:lets_connect/widgets/show_host.dart';
import 'package:lets_connect/widgets/show_location.dart';
import '../datamodels/shared_preferences.dart';

class EventWidget extends StatefulWidget {
  final Event event;
  final bool showBookmark;
  const EventWidget({Key? key, required this.event, required this.showBookmark})
      : super(key: key);
  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  bool toggle = false;
  bool isHost = false;

  @override
  Widget build(BuildContext context) {
    if (widget.event.attendees
        .contains(FireMethods.fireAuth.currentUser!.uid)) {
      toggle = true;
    }
    if (widget.event.host.contains(FireMethods.fireAuth.currentUser!.uid)) {
      isHost = true;
    }
    return FractionallySizedBox(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return ViewEventPage(event: widget.event);
              },
            ))
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 2, 5, 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        show_date(event: widget.event),
                        Text(
                          widget.event.sessionTitle,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    widget.showBookmark == true
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: IconButton(
                              onPressed: () async {
                                if (isHost == false) {
                                  setState(() {
                                    scaffoldMessengerKey.currentState
                                        ?.showSnackBar(SnackBar(
                                      duration: const Duration(seconds: 5),
                                      content: Row(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: const <Widget>[
                                          CircularProgressIndicator(
                                              color: Colors.amber),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("Updating Event")
                                        ],
                                      ),
                                    ));
                                  });

                                  if (!mounted) return;
                                  //enable to disable
                                  if (toggle) {
                                    UserData? tempUser =
                                        UserPreferences.getUser();
                                    tempUser.eventIDs
                                        .remove(widget.event.documentID);
                                    UserPreferences.setUser(tempUser);
                                    await FireMethods().updateUserEventCount(
                                        widget.event.documentID, false);
                                    if (!mounted) return;
                                    await FireMethods().updateAttendeeList(
                                        widget.event.documentID, false);
                                    scaffoldMessengerKey.currentState
                                        ?.hideCurrentSnackBar();
                                  }
                                  //disable to enable
                                  else {
                                    UserData? tempUser =
                                        UserPreferences.getUser();
                                    tempUser.eventIDs
                                        .add(widget.event.documentID);
                                    UserPreferences.setUser(tempUser);
                                    await FireMethods().updateUserEventCount(
                                        widget.event.documentID, true);
                                    if (!mounted) return;
                                    await FireMethods().updateAttendeeList(
                                        widget.event.documentID, true);
                                    scaffoldMessengerKey.currentState
                                        ?.hideCurrentSnackBar();
                                  }
                                  if (!mounted) return;

                                  setState(() {
                                    toggle = !toggle;
                                  });
                                }
                              },
                              icon: toggle == false
                                  ? const Icon(Icons.bookmark_border_outlined)
                                  : const Icon(Icons.bookmark_added_rounded),
                              iconSize: 22,
                              splashColor: Colors.amber,
                              splashRadius: 22,
                            ),
                          )
                        : Container(),
                  ],
                ),
                show_host(
                  host: widget.event.host,
                  width: 30,
                  height: 30,
                ),
                show_location(event: widget.event),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
