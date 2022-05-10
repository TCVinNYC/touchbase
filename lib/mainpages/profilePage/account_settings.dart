import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/firebase/fire_auth.dart';
import '../../datamodels/user_model.dart';

class AccountSettings extends StatefulWidget {
  final User user;
  const AccountSettings({
    Key? key,
    required this.user,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                  fontFamily: 'Frutiger',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            // const Divider(thickness: 1),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              children: [
                const Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(left: 15)),
                // const Text(
                //   'Email',
                //   style: TextStyle(fontFamily: 'Frutiger', fontSize: 16),
                // ),
                Text(
                    'admin email: ${FirebaseAuth.instance.currentUser!.email}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
