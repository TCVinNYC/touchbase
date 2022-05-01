import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Column(children: const [
            // Text(
            //   'Profile',
            //   style: TextStyle(
            //     fontFamily: 'Quicksand',
            //     fontSize: 16,
            //     color: Colors.grey,
            //   ),
            // ),
            // Divider(),
            ProfileTextField(
              text: 'Name',
            ),
            Padding(padding: EdgeInsets.only(bottom: 25)),
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

// class AccountInfo extends StatefulWidget {
//   const AccountInfo({Key? key}) : super(key: key);

//   @override
//   State<AccountInfo> createState() => _AccountInfoState();
// }

// class _AccountInfoState extends State<AccountInfo> {
//   TextEditingController controller = TextEditingController();
//   String value = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: const Text(
//           'Profile Details',
//           style: TextStyle(
//               fontFamily: 'Frutiger',
//               fontSize: 22,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(color: Colors.white60),
//         padding: const EdgeInsets.only(top: 45, left: 25, right: 25),
//         child: SingleChildScrollView(
//           child: Column(children: [
//             TextField(
//               controller: controller,
//               onChanged: (String str) {
//                 value = str;
//               },
//               // onChanged: (v) => controller.text = v,
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class ProfileTextField extends StatelessWidget {
//   final String text;
//   const ProfileTextField({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//         decoration: InputDecoration(
//             labelText: text,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             labelStyle: const TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontWeight: FontWeight.bold,
//                 // fontWeight: FontWeight.w700,
//                 fontSize: 22,
//                 color: Colors.orangeAccent),
//             border: OutlineInputBorder()
//             // helperText: 'Name',
//             // helperStyle: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
//             // enabledBorder: UnderlineInputBorder(
//             // borderSide: BorderSide(
//             // color: Colors.orangeAccent,
//             // )
//             // )
//             ));
//   }
// }

