import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
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
            floating: true,
            backgroundColor: Colors.orange,
            flexibleSpace: FlexibleSpaceBar(
              title: Positioned(
                child: Text(
                  event.sessionTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
              background: Image(
                image: event.image.image,
                fit: BoxFit.fitWidth,
                color: Colors.orangeAccent.withOpacity(.3),
                colorBlendMode: BlendMode.colorBurn,
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
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showHost(event: event, showName: true),
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
                    const Text("Description", maxLines: 1,
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
