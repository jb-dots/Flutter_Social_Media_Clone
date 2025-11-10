import 'package:flutter/material.dart';
import 'package:social_media_clone/model/usercomment.dart';
import 'package:social_media_clone/model/userdata.dart';
import 'package:social_media_clone/model/userpost.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userPost});
  final UserPost userPost;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserData userData = UserData();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();

  var nametxtstyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  var boldTxtStyle = const TextStyle(fontWeight: FontWeight.bold);
  var boldTxtStyle1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Widget commentBtn (UserComment userComment) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(userComment.commenterTime),
        const SizedBox(width: 15),
        TextButton(
          onPressed: () {
            setState(() {
              userComment.isLiked = !userComment.isLiked;
            });
          },
          child: Text(
            'Like',
            style: TextStyle(
              color: userComment.isLiked ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 15),
        TextButton(
          onPressed: () => _showReplyDialog(userComment),
          child: const Text('Reply', style: TextStyle(color: Colors.grey)),
        ),
      ],
    ),
  );

  
  Widget commentDesc (UserComment userComment) => Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userComment.commenterName, style: boldTxtStyle),
        const SizedBox(height: 5),
        Row(children: [Text(userComment.commenterContent)],),
      ],
    ),
  ); 

  
  Widget commentSpace (UserComment userComment) => Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(40, 158, 169, 67),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commentDesc(userComment),
        if (userComment.replies.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userComment.replies.map((r) => Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.commenterName, style: boldTxtStyle),
                      const SizedBox(height: 4),
                      Text(r.commenterContent),
                    ],
                  ),
                ),
              )).toList(),
            ),
          )
        ]
      ],
    ),
  );

  Widget commenterPic (UserComment userComment) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: CircleAvatar(
      backgroundImage: AssetImage(userComment.commenterImg),
    ),
  );

  void _showReplyDialog(UserComment parentComment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reply to comment'),
        content: TextField(
          controller: _replyController,
          decoration: const InputDecoration(
            hintText: 'Write your reply...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _replyController.clear();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_replyController.text.isNotEmpty) {
                setState(() {
                  parentComment.replies.add(UserComment(
                    commenterImg: userData.myUserAccount.img,
                    commenterName: userData.myUserAccount.name,
                    commenterContent: _replyController.text,
                    commenterTime: 'Now',
                  ));
                });
                Navigator.pop(context);
                _replyController.clear();
              }
            },
            child: const Text('Reply'),
          ),
        ],
      ),
    );
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      userData.commentList.insert(
        0,
        UserComment(
          commenterImg: userData.myUserAccount.img,
          commenterName: userData.myUserAccount.name,
          commenterContent: text,
          commenterTime: 'Now',
        ),
      );
      try {
        final current = int.tryParse(widget.userPost.numComments) ?? 0;
        widget.userPost.numComments = '${current + 1}';
      } catch (_) {}
    });
    _commentController.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comment posted')));
  }

  Widget usercommenterline (UserComment userComment) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      commenterPic(userComment),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commentSpace(userComment),
          commentBtn(userComment),
        ],
      )
    ],
  );

Widget userpostdetails (UserComment userComment) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    const SizedBox(height: 15),
    usercommenterline(userComment),
  ]
);

Widget commenters() => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    const Divider(color: Colors.grey),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(children: [Text(widget.userPost.numshare, style: boldTxtStyle,)
        ],
      ),
    ),
    const SizedBox(height: 15),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [Text('All comments', style:  boldTxtStyle1),
      const Icon(Icons.arrow_drop_down),

        ],
      ),
    ),
  ],  
);

Widget buttons(UserPost userpost) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Divider(
      color: Colors.grey,
    ),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: userpost.isLiked ? Colors.grey : Colors.blue,
          ),
          onPressed: () {
            setState(() {
              userpost.isLiked = !userpost.isLiked;
            });
          },
          icon: const Icon(Icons.thumb_up, size: 20),
          label: const Text('Like'),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: () {
            _showAddCommentDialog();
          },
          icon: const Icon(Icons.chat_bubble, size: 20),
          label: const Text('Comment'),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              final current = int.tryParse(userpost.numshare) ?? 0;
              userpost.numshare = '${current + 1}';
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post shared')));
          },
          icon: const Icon(Icons.share, size: 20),
          label: const Text('Share'),
          ) ,
        ],
      ),
    ),
  ],
);

  void _showAddCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                _addComment();
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  Widget userline(UserPost userpost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(userpost.userimg),
          radius: 20,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userpost.username, style: nametxtstyle,),
          const SizedBox(height: 5,),
          Row(
            children: [
              Text(userpost.time),
              const Text('.'),
              const Icon(Icons.group, size: 15, color: Colors.grey,),
            ],
          ),
        ],
      )
    ],
  );

  Widget postimage (UserPost userpost) => Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [Text(userpost.postcontent)],
        ),
        const SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            userpost.postimg,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        )
      ],
    ),
  );


   @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation:0.0,
        leading: IconButton(onPressed: (){Navigator.pop(context);},
        icon:const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          userline(widget.userPost),
          postimage(widget.userPost),
          buttons(widget.userPost),
          commenters(),
          ...userData.commentList.map((userComment) => userpostdetails(userComment)),
        ],
      ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _addComment,
                  icon: const Icon(Icons.send, color: Colors.blue),
                )
              ],
            ),
          ),
        ),
    );
  }
}