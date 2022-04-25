// Ameer Ahmed Feed page

import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //String title1 = 'some text';
    //String title2 = 'some other text';
    //String title3 = 'other text';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Feed Page'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(),
    );
  }
}
