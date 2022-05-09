import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/widgets/image_widget.dart';
import 'package:lets_connect/widgets/textfield_widget.dart';

class SetUpInfo extends StatefulWidget {
  const SetUpInfo({Key? key}) : super(key: key);

  @override
  State<SetUpInfo> createState() => _SetUpInfoState();
}

class _SetUpInfoState extends State<SetUpInfo> {
  final pronounsController = TextEditingController();
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final aboutMeController = TextEditingController();

  File? image;
  Image imageAsset = Image.asset('assets/images/blank-pfp.png');

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
              padding: const EdgeInsets.all(20),
              child: image != null
                  ? ImageWidget(
                      image: image!,
                      onClicked: (source) => pickImage(context, source),
                      height: 175,
                      width: 175,
                      enableEditButton: true,
                      circular: true,
                    )
                  : ImageWidget(
                      imageAsset: imageAsset,
                      enableImageInk: true,
                      onClicked: (source) => pickImage(context, source),
                      height: 175,
                      width: 175,
                      enableEditButton: false,
                      circular: true,
                    ),
            ),
            TextFieldWidget(
                labelText: 'Pronouns', controller: pronounsController),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            TextFieldWidget(labelText: 'Title', controller: titleController),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            TextFieldWidget(
                labelText: 'Company', controller: companyController),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            SizedBox(
              // height: 190,
              child: TextField(
                controller: aboutMeController,
                maxLines: 5,
                maxLength: 179,
                decoration: const InputDecoration(
                    labelText: 'About Me',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () async {
                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Please upload an image of yourself :)')));
                  } else if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Title cannot be empty')));
                  } else if (companyController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Company cannot be empty')));
                  } else if (aboutMeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please provide some details about yourself :)')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Uploading, Please wait...')));
                    String result = await FireMethods().uploadUserData(
                        pronounsController.text,
                        FireMethods.fireAuth.currentUser!.displayName!,
                        titleController.text,
                        companyController.text,
                        aboutMeController.text,
                        [],
                        [],
                        [],
                        [],
                        [],
                        image);
                    if (result == "done") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Congrats Your Account Has Been Created!")));

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainPage()));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    }
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
