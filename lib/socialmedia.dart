import 'package:flutter/material.dart';
import 'package:social_media_clone/model/userdata.dart';
import 'package:social_media_clone/views/friendlist.dart';
import 'package:social_media_clone/views/infoheader.dart';
import 'package:social_media_clone/views/mainheader.dart';
import 'package:social_media_clone/views/postlist.dart';

class Socialmedia extends StatefulWidget {
  const Socialmedia({super.key});

  @override
  State<Socialmedia> createState() => _SocialmediaState();
}

class _SocialmediaState extends State<Socialmedia> {
  UserData userData = UserData();

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Mainheader(userData: userData),
          Infoheader(userData: userData),
          Friendlist(userData: userData),
          const SizedBox(height: 20),
          Padding(padding: 
          const EdgeInsets.only(left: 8),
          child: Row(children: [
            Text('Posts', style: followTxtStyle,)],
          ),),
          const SizedBox(height: 20),
          Postlist(userdata: userData),
        ],
      )
    );
  }
}