import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/datamodels/shared_preferences.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import 'package:lets_connect/main.dart';
import 'package:lets_connect/mainpages/profilePage/side_menu_button.dart';
import '../../datamodels/user_model.dart';

class AccountSettings extends StatefulWidget {
  // final User user;
  const AccountSettings({
    Key? key,
    // required this.user,
  }) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'Frutiger',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Account',
            //       style: TextStyle(
            //           fontFamily: 'Frutiger',
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.orange),
            //     ),
            //     //    ],
            //     //  ),
            //     // const Divider(thickness: 1),
            //     const Padding(
            //       padding: EdgeInsets.only(bottom: 10),
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(5),
            //       height: 40,
            //       decoration: BoxDecoration(color: Colors.black12),
            //       child: Row(
            //         children: [
            //           const Icon(
            //             Icons.mail_outline_rounded,
            //             color: Colors.grey,
            //           ),
            //           const Padding(padding: EdgeInsets.only(left: 15)),
            //           // const Text(
            //           //   'Email',
            //           //   style: TextStyle(fontFamily: 'Frutiger', fontSize: 16),
            //           // ),
            //           // Text("${user!.email}"),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            InkWell(
              hoverColor: Colors.red,
              onTap: () async {
                showAlertDialog(context);
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.highlight_remove_outlined, color: Colors.red),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      'Delete Account',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.red,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton.icon(
      onPressed: () async {
        String result = await deleteAllData();
        User user = await FirebaseAuth.instance.currentUser!;
        user.delete();
        await signOutFromGoogle();
        UserPreferences.resetUser();
        FirebaseAuth.instance.currentUser?.reload();
        // await
        FirebaseAuth.instance.authStateChanges;
        print(result);
        if (result == "done") {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MyHomePage(),
            ),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Your Account was deleted")));
        }
      },
      icon: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.red,
      ),
      label: const Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ));
  Widget cancel = TextButton.icon(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        //find a away to make the dialog disappear
      },
      icon: const Icon(Icons.cancel),
      label: const Text("Cancel"));

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Account Deletion"),
    content: const Text("Are you sure you want to delete your account?"),
    actions: [okButton, cancel],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
