import 'package:flutter/material.dart';
import 'package:social_media_clone/model/userdata.dart';

class Infoheader extends StatelessWidget {
  Infoheader({super.key, required this.userData});
  final UserData userData;

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('Followers'), Text('Following'), Text('Post')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(userData.myUserAccount.numFollowers, style: followTxtStyle),
            Text(userData.myUserAccount.numFollowing, style: followTxtStyle),
            Text(userData.myUserAccount.numPosts, style: followTxtStyle),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey),
      ],
    );
  }
}