import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/widgets/textfield_widget.dart';

class AccountInfo extends StatefulWidget {
  final UserData userData;
  const AccountInfo({Key? key, required this.userData}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  var nameController = TextEditingController();
  var pronounsController = TextEditingController();
  var titleController = TextEditingController();
  var companyController = TextEditingController();
  var aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.userData.name;
    pronounsController.text = widget.userData.prounouns;
    titleController.text = widget.userData.title;
    companyController.text = widget.userData.company;
    aboutMeController.text = widget.userData.aboutMe;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Profile Details',
          style: TextStyle(
              fontFamily: 'Frutiger',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white60),
        padding: const EdgeInsets.only(top: 45, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(children: [
            TextFieldWidget(labelText: 'Name', controller: nameController),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
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
                  if (nameController.text.isEmpty) {
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
                  }
                },
                child: const Text(
                  'Save & Submit',
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
