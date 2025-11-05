import 'package:social_media_clone/model/account.dart';
import 'package:social_media_clone/model/friend.dart';
import 'package:social_media_clone/model/usercomment.dart';
import 'package:social_media_clone/model/userpost.dart';

class UserData {
  List<UserPost> userList = [
    UserPost(
      userimg: 'assets/person1.jpg',
      username: 'John Doe',
      time: '2 hrs ago',
      postcontent: 'Had a great time at the beach!',
      postimg: 'assets/amazing.jpg',
      numshare: '10',
      numComments: '24',
    ),
    UserPost(
      userimg: 'assets/person2.jpg',
      username: 'Jane Smith',
      time: '1 hr ago',
      postcontent: 'Loving the new cafe in town!',
      postimg: 'assets/pavlova.jpg',
      numshare: '20',
      numComments: '15',
    ),
    UserPost(
      userimg: 'assets/person3.jpg',
      username: 'Mike Johnson',
      time: '30 mins ago',
      postcontent: 'Just finished a marathon!',
      postimg: 'assets/person3.jpg ',
      numshare: '5',
      numComments: '2',
    ),
  ];
  List<Friend> friendList = [
    Friend(name: 'Alice', img: 'assets/person1.jpg'),
    Friend(name: 'Bob', img: 'assets/person2.jpg'),
    Friend(name: 'Charlie', img: 'assets/person3.jpg'),
    Friend(name: 'Diana', img: 'assets/person4.jpg'),
    Friend(name: 'Ethan', img: 'assets/person5.jpg'),
  ];

  List <UserComment> commentList = [
    UserComment(
      commenterImg: 'assets/person1.jpg',
      commenterName: 'Sophia',
      commenterContent: 'Wow, that looks amazing!',
      commenterTime: '1 hr ago',
    ),
    UserComment(
      commenterImg: 'assets/person2.jpg',
      commenterName: 'Liam',
      commenterContent: 'Great job on the marathon!',
      commenterTime: '30 mins ago',
    ),
    UserComment(
      commenterImg: 'assets/person4.jpg',
      commenterName: 'Olivia',
      commenterContent: 'I need to check out that cafe!',
      commenterTime: '15 mins ago',
    ),
  ];

  Account myUserAccount = Account(
    name: 'John Doe',
    email: 'john_doe@example.com',
    password: 'password123',
    img: 'assets/yuh.jpg',
    numFollowers: '150',
    numFollowing: '200',
    numPosts: '75',
    numFriends: '50',
  );
}