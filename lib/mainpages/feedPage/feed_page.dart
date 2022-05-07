import 'package:flutter/material.dart';
import 'package:lets_connect/widgets/feed_post.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'TouchBase',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          )),
      body:
          // Center(
          // child:
          SingleChildScrollView(
        child: Column(
          children: const [
            //this adds another column if called again
            FeedPost(
              profileImage:
                  'https://i.pinimg.com/564x/60/30/f6/6030f6dd1b76cfc79b9125206dfa46fa.jpg',
              userName: 'Flora',
              titleCompany: 'Fairy at Winx',
            ),
            FeedPost(
              profileImage:
                  'https://i.pinimg.com/736x/54/a4/29/54a429ef86304600bf4d4df32398625c.jpg',
              userName: 'Danny Phantom',
              titleCompany: 'Ghost Hunter at Phantom Business',
              description:
                  'Just found out i can turn into a phantom, these ghosts better watch out cuz im changing the game',
            ),
            FeedPost(
              profileImage:
                  'https://data.whicdn.com/images/344524632/original.jpg',
              userName: 'Stitch',
              titleCompany: 'Just Stitch in Hawaii',
              description: 'getting ice cream with Lilo my fav human',
              postImage:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyT2v7b4F0oYGXrtNZWkJjugFFUzvZKGtR7-xhw30sazBh_5HAOseUz_gcL_HYMauHyeU&usqp=CAU',
            ),
            FeedPost(
              profileImage: 'https://avatarfiles.alphacoders.com/833/83315.png',
              userName: 'SpongeBob',
              titleCompany: 'Chef at Krusty Crabs',
              postImage: 'https://i.redd.it/juhoyw0mwnp61.jpg',
            )
          ],
        ),
      ),
      // ),
    );
  }
}
