import 'package:flutter/material.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({
    Key? key,
    required this.profileImage,
    required this.userName,
    required this.titleCompany,
    this.description,
    this.postImage,
  }) : super(key: key);

  final String profileImage;
  final String userName;
  final String titleCompany;
  final String? description;
  final String? postImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.blueGrey,
                  border: Border.all(color: Colors.black26),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(profileImage),
                          // backgroundImage: profileImage,
                          radius: 40,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                  fontFamily: 'Frutiger',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text(
                              titleCompany,
                              style: const TextStyle(
                                  fontFamily: 'Frutiger', fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 10),
                    // ),
                    // const Divider(thickness: 1),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    description != null
                        ? Text(description!,
                            style: const TextStyle(
                              fontFamily: 'Frutiger',
                              fontSize: 15,
                              height: 1.2,
                            ))
                        : Container(),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    if (postImage != null)
                      Image(image: NetworkImage(postImage!))
                    else
                      Container(),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.thumb_up_outlined,
                              // color: Colors.orange,
                              size: 25,
                            )),
                      ],
                    ),
                  ]),
            )));
  }
}
