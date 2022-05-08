import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/event.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/profilePage/profile_info.dart';

class showHost extends StatelessWidget {
  const showHost({
    Key? key,
    required this.host,
    this.showName,
    required this.width,
    required this.height,
  }) : super(key: key);

  final List<dynamic> host;
  final bool? showName;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        UserData? myUser = await FireMethods().getUserData(host[3]);
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
                            ProfileInfo(userData: myUser!),
                          ],
                        ),
                      ),
                  );
                  // return Container(
                  //   decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  //   ),
                  //   child: ListView(
                  //     controller: controller,
                  //     children: [
                  //       ProfileInfo(userData: myUser!),
                  //     ],
                  //   ),
                  // );
                },
              );
            });
        // Navigator.push(context, MaterialPageRoute<void>(
        //   // builder: (BuildContext context) {
        // showModalBottomSheet(
        // context: context,
        //         builder: (context) {
        //           return ProfileInfo(userData: myUser!);
        // return Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.orange,
        //   ),
        //   body: SingleChildScrollView(
        //     child: Column(
        //       children: <Widget>[
        //         ProfileInfo(userData: myUser!),
        //       ],
        //     ),
        //   ),
        // );
        // });
        //   // return Container();
        //   // },
        // ));
      },
      child: Container(
        alignment: const Alignment(-1.035, 0),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 2.3,
          children: [
            showName == null || false
                ? withOutTitle(host, width, height)
                : withTitle(host, width, height),
          ],
        ),
      ),
    );
  }
}

withOutTitle(List<dynamic> host, width, height) {
  return Row(
    children: [
      Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        type: MaterialType.circle,
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(host[2]),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      ),
      const SizedBox(width: 5),
      Text(
        host[0],
        style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ),
    ],
  );
}

withTitle(List<dynamic> host, width, height) {
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
          image: NetworkImage(host[2]),
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
            host[0],
            style: const TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          Text(
            host[1],
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
