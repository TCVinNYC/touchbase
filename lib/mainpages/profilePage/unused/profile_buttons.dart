import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width * 0.93,
        height: 55,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 249, 234),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            Icon(icon, size: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25,
            )
          ],
        ));
  }
}
