import 'package:flutter/material.dart';
import 'package:social_media_clone/model/userdata.dart';

class Mainheader extends StatelessWidget {
   Mainheader({super.key, required this.userData});
   final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(userData.myUserAccount.img),
        ),
        const SizedBox(height: 10),
        Text(
          userData.myUserAccount.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          userData.myUserAccount.email,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}