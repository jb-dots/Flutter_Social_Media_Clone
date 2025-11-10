class UserComment {
  final String commenterName;
  final String commenterTime;
  final String commenterImg;
  final String commenterContent;
  bool isLiked;
  List<UserComment> replies;

  UserComment({
    required this.commenterName,
    required this.commenterTime,
    required this.commenterImg,
    required this.commenterContent,
    this.isLiked = false,
    List<UserComment>? replies,
  }) : replies = replies ?? [];
}