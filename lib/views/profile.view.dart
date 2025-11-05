import 'package:flutter/material.dart';
import 'package:social_media_clone/model/usercomment.dart';
import 'package:social_media_clone/model/userdata.dart';
import 'package:social_media_clone/model/userpost.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key, required this.userPost});
  final UserPost userPost;
  final UserData userData = UserData();

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
        const Text('Like'),
        const SizedBox(width: 15,),
        const Text('Reply'),
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
    child: commentDesc(userComment),
  );

  Widget commenterPic (UserComment userComment) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: CircleAvatar(
      backgroundImage: AssetImage(userComment.commenterImg),
    ),
  );

  Widget usercommenterline (UserPost userpost, UserComment userComment) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      commenterPic(userComment),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commentSpace(userComment), commentBtn(userComment)],
      )
    ],
  );

Widget userpostdetails (UserComment userComment) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    const SizedBox(height: 15),
    usercommenterline(userPost, userComment),
  ]
);

Widget commenters(UserPost userpost) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    const Divider(color: Colors.grey),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(children: [Text(userPost.numshare, style: boldTxtStyle,)
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
          onPressed: () {},
          icon: const Icon(Icons.thumb_up, size: 20),
          label: const Text('Like'),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble, size: 20),
          label: const Text('Comment'),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: () {},
          icon: const Icon(Icons.share, size: 20),
          label: const Text('Share'),
          ) ,
        ],
      ),
    ),
  ],
);

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
        children: [
          userline(userPost),
          postimage(userPost),
          buttons(userPost),
          commenters(userPost),
          ...userData.commentList.map((userComment) => userpostdetails(userComment)),
        ],
      ),
    );
  }
}