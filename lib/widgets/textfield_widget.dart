import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
        decoration: InputDecoration(
      labelText: text,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
          // fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Colors.orangeAccent),
      border: const OutlineInputBorder(),
    ));
  }
}
