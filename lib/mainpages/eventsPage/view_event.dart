import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/widgets/showDate.dart';
import 'package:lets_connect/widgets/showHost.dart';
import 'package:lets_connect/widgets/showLocation.dart';
import 'package:lets_connect/widgets/showOtherDetails.dart';

class ViewEventPage extends StatelessWidget {
  final Event event;

  const ViewEventPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              event.host[3] == UserPreferences.getUser().userID
                      ? GestureDetector(
                          onTap: () {
                            showAlertDialog(context, event.documentID);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.delete,
                              size: 23,
                              color: Colors.red.shade500,
                            ),
                          ),
                        )
                      : Container(),
            ],
            floating: true,
            snap: true,
            backgroundColor: Colors.orange,
            flexibleSpace: FlexibleSpaceBar(
              background: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ).createShader(
                      Rect.fromLTRB(0, -140, rect.width, rect.height - 20));
                },
                blendMode: BlendMode.darken,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: event.image.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              expandedTitleScale: 1.3,
              title: Text(
                event.sessionTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              
            ),
            pinned: true,
            forceElevated: true,
            expandedHeight: MediaQuery.of(context).size.height * .27,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 700,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showHost(
                        host: event.host,
                        width: 35,
                        height: 35,
                        showName: true),
                    showLocation(event: event, showName: true),
                    showDate(event: event, showIcon: true),
                    const SizedBox(height: 5),
                    const Divider(
                      height: 20,
                      thickness: 0.5,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    const Text("Description",
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(event.description,
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 14,
                                fontWeight: FontWeight.w400))),
                    const Divider(
                      height: 20,
                      thickness: 0.5,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    const Text("Other Details",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    showOtherDetails(
                        text: event.category,
                        showIcon: true,
                        icon: Icons.dashboard_sharp,
                        color: Colors.teal),
                    showOtherDetails(
                        text: event.age == false
                            ? "For Everyone :)"
                            : "Only Ages 21+",
                        showIcon: true,
                        icon: event.age == false
                            ? Icons.no_drinks_rounded
                            : Icons.wine_bar_rounded,
                        color: Colors.indigo),
                    showOtherDetails(
                        text: event.paid == false ? "For FREE :)" : event.price,
                        showIcon: true,
                        icon: event.paid == false
                            ? Icons.money_off_csred_rounded
                            : Icons.currency_exchange,
                        color: Colors.green),
                    const Divider(
                      height: 20,
                      thickness: 0.5,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    const Text("Attendees",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            // const SizedBox(
            //   height: 1000,
            //   child: Center(
            //     child: Text(
            //       "Scroll",
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // )
          ]))
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, String postID) {
  // Create button
  Widget okButton = TextButton.icon(
      onPressed: () async {
        String result =
            await deleteMyEvent(UserPreferences.getUser().userID, postID);
        if (result == "done") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Event Deleted')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
        Navigator.of(context, rootNavigator: true).pop();
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
    title: const Text("Event Deletion"),
    content: const Text("Are you sure you want to delete your event?"),
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