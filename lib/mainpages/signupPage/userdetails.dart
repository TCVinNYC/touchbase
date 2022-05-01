import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_connect/widgets/image_widget.dart';

class SetUpInfo extends StatefulWidget {
  const SetUpInfo({Key? key}) : super(key: key);

  @override
  State<SetUpInfo> createState() => _SetUpInfoState();
}

class _SetUpInfoState extends State<SetUpInfo> {
  File? image;

  AssetImage imageAsset = const AssetImage('assets/images/upload_image.jpg');
  Future pickImage(context, ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 60,
      );
      if (image == null) return;
      setState(() => this.image = File(image.path));
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white60),
        padding: const EdgeInsets.only(top: 45, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle
                  // border: Border.all(width: 0.6, color: Colors.black87),
                  ),
              // CircleAvatar(
              child: image != null
                  ? ImageWidget(
                      image: image!,
                      onClicked: (source) => pickImage(context, source),
                      height: 200,
                      width: 200,
                      enableEditButton: true,
                    )
                  : ImageWidget(
                      imageAsset: imageAsset,
                      onClicked: (source) => pickImage(context, source),
                      height: 200,
                      width: 200,
                      enableEditButton: false,
                    ),
            ),
            // ),
            ProfileTextField(text: 'Pronouns'),
            Padding(padding: EdgeInsets.only(bottom: 25)),
            ProfileTextField(text: 'Title'),
            Padding(padding: EdgeInsets.only(bottom: 25)),
            ProfileTextField(text: 'Company'),
            Padding(padding: EdgeInsets.only(bottom: 25)),
            SizedBox(
              // height: 190,
              child: TextField(
                maxLines: 5,
                maxLength: 179,
                decoration: InputDecoration(
                    labelText: 'About Me',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                    border: OutlineInputBorder()),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String text;
  const ProfileTextField({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            labelText: text,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                // fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.orangeAccent),
            border: OutlineInputBorder()
            // helperText: 'Name',
            // helperStyle: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
            // enabledBorder: UnderlineInputBorder(
            // borderSide: BorderSide(
            // color: Colors.orangeAccent,
            // )
            // )
            ));
  }
}
