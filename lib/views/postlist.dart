import 'package:flutter/material.dart';
import 'package:social_media_clone/model/userdata.dart';
import 'package:social_media_clone/model/userpost.dart';
import 'package:social_media_clone/views/profile.view.dart';

class Postlist extends StatefulWidget {
  const Postlist({super.key, required this.userdata});

  final UserData userdata;
  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  var nametxtStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final TextEditingController _commentController = TextEditingController();

  void _showCommentDialog(BuildContext context, UserPost userpost) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Write your comment...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _commentController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  setState(() {
                    // Add the comment to the post
                    userpost.numComments = '${int.parse(userpost.numComments) + 1}';
                  });
                  Navigator.pop(context);
                  _commentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Comment added successfully!')),
                  );
                }
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }

gotoPage(BuildContext context, dynamic page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

Widget buttons(UserPost userpost) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: (userpost.isLiked) ? Colors.blue : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          userpost.isLiked = (userpost.isLiked) ? false : true;
        });
      },
      icon: const Icon(Icons.thumb_up),
      label: const Text('Like'),
    ),
    TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: () {
            _showCommentDialog(context, userpost);
          },
          icon: const Icon(Icons.message),
          label: const Text('Comment'),
    ),
    TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: () {},
          icon: const Icon(Icons.share),
          label: const Text('Share'),
    ),
  ],
);  

Widget postCount(UserPost userpost) => Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Text('${userpost.numComments} Comments'),
    const Text(''),
    const SizedBox(width: 20),
    Text('${userpost.numshare} Shares'),
  ],
);

Widget postImage(UserPost userpost) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 10),
  child: Container(
    height: 350,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(userpost.postimg),
        fit: BoxFit.fill,
        ),
      ),
    ),   
  );

Widget postHeader(UserPost userpost) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(userpost.userimg),
      ),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userpost.username, style: nametxtStyle),
        Row(
          children: [
            Text('${userpost.time} . '),
            const Icon(Icons.people, size: 18),
          ],
        ),
      ],
    ),
  ],
);

Widget showPost(UserPost userpost) => Column(
  children: [
    postHeader(userpost),
    Container(
      margin: const EdgeInsets.all(8),
      child: Row(children: [Text(userpost.postcontent, style: nametxtStyle)]),
    ),
    postImage(userpost),
    postCount(userpost),
    const Divider(),
    buttons(userpost),
    SizedBox(height: 10, child: Container(color: Colors.grey)),
    const SizedBox(height: 15),
  ],
);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.userdata.userList.length,
      itemBuilder: (context, index) {
        final post = widget.userdata.userList[index];
        return InkWell(
          onTap: () {
            gotoPage(context, ProfileView(userPost: post));
          },
          child: showPost(post),
        );
      },
    );
  }
}