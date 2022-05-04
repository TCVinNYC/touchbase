import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';

class showHost extends StatelessWidget {
  const showHost({
    Key? key,
    required this.event,
    this.showName,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Event event;
  final bool? showName;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
      //Stream<UserData> myUser = await FireMethods().getUserData(event.host[3]);
      UserData? myUser = await FireMethods().getUserData(event.host[3]);
       print(myUser);
      },
      child: Container(
        alignment: const Alignment(-1.035, 0),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
        //alignment: Alignment.,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 2.3,
          children: [
            showName == null
                ? withOutTitle(event, width, height)
                : withTitle(event, width, height),
          ],
        ),
      ),
    );
  }
}

withOutTitle(Event event, width, height) {
  return Row(
    children: [
      Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        type: MaterialType.circle,
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(event.host[2]),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      ),
      const SizedBox(width: 5),
      Text(
        event.host[0],
        style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ),
    ],
  );
}

withTitle(Event event, width, height) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        type: MaterialType.circle,
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(event.host[2]),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      ),
      const SizedBox(width: 8),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.host[0],
            style: const TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          Text(
            event.host[1],
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black45.withOpacity(0.7),
                fontSize: 14),
          ),
        ],
      ),
    ],
  );
}
