class Comment {
  final String userId;
  final String userImage;
  final String userName;
  final String content;
  final String timestamp;
  bool isLiked;
  List<Comment> replies;

  Comment({
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.content,
    required this.timestamp,
    this.isLiked = false,
    List<Comment>? replies,
  }) : replies = replies ?? [];
}