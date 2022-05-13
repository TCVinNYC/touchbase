import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/post_model.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/mainpages/feedPage/create_post.dart';
import 'package:lets_connect/widgets/post_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Post> _posts = [];
  UserData userData = UserPreferences.getUser();

  void getPosts() async {
    var temp = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timeOfPost', descending: true)
        .get()
        .then((value) =>
            value.docs.map((doc) => Post.fromJson(doc.data())).toList());
    var userTemp = UserPreferences.getUser();
    setState(() {
      _posts = temp;
      userData = userTemp;
    });
  }

  Future<void> _getData() async {
    setState(() {
      getPosts();
    });
  }


  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const CreatePostPage());
              },
              icon: const Icon(Icons.add_box_rounded),
              color: Colors.orange,
            )
          ],
          title: const Text(
            'TouchBase',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          )),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: SafeArea(
          top: false,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _posts.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return FeedPost(
                  post: _posts[index],
                  user: userData,
                );
              }),
        ),
      ),
    );
  }
}