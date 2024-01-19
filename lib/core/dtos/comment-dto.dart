import 'package:intl/intl.dart';

class CommentDTO {
  String name;
  String? avatar;
  String content;
  int rating;
  DateTime updatedAt;

  CommentDTO(
      {required this.name,
      required this.avatar,
      required this.content,
      required this.rating,
      required this.updatedAt});

  static CommentDTO fromJson(comment) {
    return CommentDTO(
        name: comment["firstInfo"]["name"],
        avatar: comment["firstInfo"]["avatar"],
        content: comment["content"],
        updatedAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'")
            .parseUtc(comment["updatedAt"])
            .toLocal(),
        rating: comment["rating"] ?? 0);
  }
}
