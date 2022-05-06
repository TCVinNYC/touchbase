// Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,

//   ),
// ),

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/post_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/feedPage/create_post.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
    );
  }
}
/**
 *             ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                  builder: (context) => const CreatePostPage());
                },
                child: const Text("new post")),
 */

/**            ElevatedButton(
                onPressed: () async {
                  print("uploading");

                  File? file;
                  String? postText;
                  FireMethods().uploadPost(DateTime.now(), postText,
                      ["fewf", "wsfghfds", "hfders", "dsggs"], [], file);
                },
                child: const Text("upload")),
            ElevatedButton(
                onPressed: () async {
                  print("reading");

                  var list = FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots()
                      .map((snapshot) => snapshot.docs
                          .map((doc) => Post.fromJson(doc.data()))
                          .toList());
                },
                child: const Text("read")), */