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
    // UserData? userData =
    //     await FireMethods().getUserData(FireMethods.fireAuth.currentUser!.uid);
    var userTemp = UserPreferences.getUser();
    setState(() {
      _posts = temp;
      userData = userTemp;
      print(userData.likedPosts);
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

        // body: SafeArea(
        //   top: false,
        //   bottom: false,
        //   child: StreamBuilder<List<Post>>(
        //     stream: getPosts(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return Text(
        //             "Something when wrong!" + snapshot.error.toString());
        //       } else if (snapshot.hasData) {
        //         final posts = snapshot.data!;
        //         return ListView.separated(
        //           itemBuilder: (BuildContext context, int index) {
        //             return FeedPost(post: posts[index]);
        //           },
        //           itemCount: posts.length,
        //           separatorBuilder: (BuildContext context, int index) {
        //             return Container();
        //           },
        //         );
        //       } else {
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //     },
        //   ),
        // )

// Stream<List<Post>> getPosts() =>
//     FirebaseFirestore.instance.collection('posts').snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());

        //  SingleChildScrollView(
        //   child: Column(
        //     children: const [
        //       //this adds another column if called again
        //       FeedPost(
        //         profileImage:
        //             'https://i.pinimg.com/564x/60/30/f6/6030f6dd1b76cfc79b9125206dfa46fa.jpg',
        //         userName: 'Flora',
        //         titleCompany: 'Fairy at Winx',
        //       ),
        //       FeedPost(
        //         profileImage:
        //             'https://i.pinimg.com/736x/54/a4/29/54a429ef86304600bf4d4df32398625c.jpg',
        //         userName: 'Danny Phantom',
        //         titleCompany: 'Ghost Hunter at Phantom Business',
        //         description:
        //             'Just found out i can turn into a phantom, these ghosts better watch out cuz im changing the game',
        //       ),
        //       FeedPost(
        //         profileImage:
        //             'https://data.whicdn.com/images/344524632/original.jpg',
        //         userName: 'Stitch',
        //         titleCompany: 'Just Stitch in Hawaii',
        //         description: 'getting ice cream with Lilo my fav human',
        //         postImage:
        //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyT2v7b4F0oYGXrtNZWkJjugFFUzvZKGtR7-xhw30sazBh_5HAOseUz_gcL_HYMauHyeU&usqp=CAU',
        //       ),
        //       FeedPost(
        //         profileImage: 'https://avatarfiles.alphacoders.com/833/83315.png',
        //         userName: 'SpongeBob',
        //         titleCompany: 'Chef at Krusty Crabs',
        //         postImage: 'https://i.redd.it/juhoyw0mwnp61.jpg',
        //       )
        //     ],
        //   ),
        // ),
        // ),