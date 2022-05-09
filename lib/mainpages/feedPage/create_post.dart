import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/mainpages/feedPage/feed_page.dart';
import 'package:lets_connect/mainpages/main_view_switcher.dart';
import 'package:lets_connect/widgets/image_widget.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File? image;
  Image imageAsset = Image.asset('assets/images/upload_image.jpg');
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

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      snap: true,
      snapSizes: const [0.4, 0.65, 0.9],
      builder: (_, controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Create a Post',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w800,
                fontSize: 25),
            textAlign: TextAlign.start,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: ListView(
              controller: controller,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Share Your Thoughts",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'This post is about horseshoes and handgrenades...',
                        ),
                        keyboardType: TextInputType.multiline,
                        //minLines: 1,
                        maxLines: 5,
                        //inputFormatters: [MaxLinesTextInputFormatter(5)],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black38,
                ),

                //Photo
                const Text(
                  "Featured photo",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),

                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6, color: Colors.black87),
                      ),
                      child: image != null
                          ? ImageWidget(
                              image: image!,
                              onClicked: (source) => pickImage(context, source),
                              height: 175,
                              width: 750,
                              enableEditButton: true,
                              circular: false,
                            )
                          : ImageWidget(
                              imageAsset: imageAsset,
                              onClicked: (source) => pickImage(context, source),
                              height: 175,
                              width: 750,
                              enableEditButton: false,
                              circular: false,
                              enableImageInk: true,
                            ),
                    )),

                const Divider(
                  thickness: 0.5,
                  color: Colors.black38,
                ),

                const SizedBox(
                  height: 25,
                ),

                Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () async {
                      if (textController.text.isEmpty && image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Cannot upload an empty post!')));
                      } else {
                        UserData? user = await FireMethods()
                            .getUserData(FireMethods.fireAuth.currentUser!.uid);
                        List<dynamic> poster = [
                          user?.name,
                          user?.title,
                          user?.profilePic,
                          user?.userID
                        ];
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Uploading, Please wait...')));
                        String result = await FireMethods().uploadPost(
                            DateTime.now(),
                            textController.text.isEmpty
                                ? null
                                : textController.text,
                            poster,
                            [],
                            image);
                        if (result == "done") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainPage()),
                            (Route<dynamic> route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Congrats Your Post Has Been Uploaded!")));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(result)));
                        }
                      }
                    },
                    child: const Text(
                      'Upload Post',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
