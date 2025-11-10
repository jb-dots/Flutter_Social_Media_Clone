import 'comment.dart';

class UserPost {
  final String userimg;
  final String username;
  final String time;
  final String postcontent;
  final String postimg;
  String numshare;
  String numComments;
  bool isLiked;
  List<Comment> comments = [];

  UserPost({
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numshare,
    required this.numComments,
    this.isLiked = false,
  });
}