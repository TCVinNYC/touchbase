import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/datamodels/user_model.dart';
import 'package:lets_connect/firebase/firestore.dart';
import 'package:lets_connect/widgets/custom_category.dart';
import 'package:lets_connect/widgets/image_widget.dart';
import 'package:lets_connect/widgets/max_lines.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEventPage> {
  TimeOfDay? timeSelect = TimeOfDay.now();
  late String? timeSelect_formatted = timeSelect?.format(context);

  DateTime dateSelect = DateTime.now();
  late String dateSelect_formatted = DateFormat.yMd().format(dateSelect);

  late DateTime finalDateTime;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateSelect, // Refer step 1
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != dateSelect) {
      setState(() {
        dateSelect = picked;
        dateSelect_formatted = DateFormat.yMd().format(dateSelect);
      });
    }
  }

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

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationNameController = TextEditingController();
  final locationAddressController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationNameController.dispose();
    locationAddressController.dispose();
    priceController.dispose();
    super.dispose();
  }

  bool priceEnable = false;
  bool adultEnable = false;

  List<String> selectedCategories = [];
  // int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Create an event',
          style: TextStyle(
              color: Colors.black,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Title
              const Text(
                "Title",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your event title',
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.black38,
              ),

              //Date & Time
              const Text(
                "Date and time",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(225, 255, 183, 0),
                      ),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Text(dateSelect_formatted.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'QuickSand',
                            fontSize: 17,
                          )),
                    ),
                  ),
                  const Text("  ─  ",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(225, 255, 183, 0),
                      ),
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: timeSelect!);
                        if (newTime != null) {
                          setState(() {
                            timeSelect = newTime;
                            timeSelect_formatted = timeSelect?.format(context);
                          });
                        }
                      },
                      child: Text(timeSelect_formatted.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'QuickSand',
                            fontSize: 17,
                          )),
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'This event is awesome because...',
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      inputFormatters: [MaxLinesTextInputFormatter(5)],
                    ),
                  ),
                ],
              ),

              const Divider(
                thickness: 0.5,
                color: Colors.black38,
              ),

              const Text(
                "Location",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: locationNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name of Location',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: locationAddressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add full addreess',
                  ),
                ),
              ),

              const Divider(
                thickness: 0.5,
                color: Colors.black38,
              ),

              Row(
                children: [
                  const Text('Pay to Attend?',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  const Spacer(),
                  Switch(
                    value: priceEnable,
                    onChanged: (value) {
                      setState(() {
                        priceEnable = value;
                      });
                    },
                    activeTrackColor: Colors.orangeAccent,
                    activeColor: Colors.orange,
                  ),
                ],
              ),
              priceEnable == true
                  ? Row(
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            controller: priceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '\$',
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),

              const Divider(
                thickness: 0.5,
                color: Colors.black38,
              ),

              const SizedBox(
                height: 5,
              ),
              const Text('Select a Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),

              CustomCategory(
                enableMultiselect: false,
                selectedCategories: selectedCategories,
              ),

              const Divider(
                thickness: 0.5,
                color: Colors.black38,
              ),

              Row(
                children: [
                  const Text('Only for 21+?',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  const Spacer(),
                  Switch(
                    value: adultEnable,
                    onChanged: (value) {
                      setState(() {
                        adultEnable = value;
                      });
                    },
                    activeTrackColor: Colors.orangeAccent,
                    activeColor: Colors.orange,
                  ),
                ],
              ),
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
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Event title cannot be empty!')));
                    } else if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Must upload an image!')));
                    } else if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Please add a description for your event!')));
                    } else if (locationNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Please provide the name of the location!')));
                    } else if (locationAddressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Please provide the address of the location!')));
                    } else if (priceEnable == true &&
                        priceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Must provide a price for your event!')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Uploading, Please wait...')));
                      if (priceEnable == false) {
                        priceController.text = "0";
                      }

                      UserData? user = await FireMethods()
                          .getUserData(FireMethods.fireAuth.currentUser!.uid);
                      List<dynamic> host = [
                        user?.name,
                        user?.title,
                        user?.profilePic,
                        user?.userID
                      ];

                      finalDateTime = DateTime(
                          dateSelect.year,
                          dateSelect.month,
                          dateSelect.day,
                          timeSelect!.hour,
                          timeSelect!.minute);

                      String result = await FireMethods().uploadEvent(
                          titleController.text,
                          finalDateTime,
                          descriptionController.text,
                          locationNameController.text,
                          locationAddressController.text,
                          priceController.text,
                          priceEnable,
                          selectedCategories.first,
                          adultEnable,
                          host,
                          image);
                      if (result == "done") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Congrats Your Event Has Been Created!")));
                        Navigator.of(context).pop();
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
            ],
          ),
        ),
      ),
    );
  }
}
