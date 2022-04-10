import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EventPostContainer extends StatelessWidget {
  final Post post;

  const EventPostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 100,
      color: Colors.red,
      child: Container(),
    );
  }
}

class Post {}
