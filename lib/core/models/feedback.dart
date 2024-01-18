class Feedback {
  static int _idCounter = 0;

  int id;
  String content;
  int rating;
  String authorName;
  String? authorAvatar;
  DateTime createdAt;
  DateTime updatedAt;

  Feedback({
    required this.content,
    required this.rating,
    required this.authorName,
    this.authorAvatar,
  })  : id = _idCounter++,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();
}
