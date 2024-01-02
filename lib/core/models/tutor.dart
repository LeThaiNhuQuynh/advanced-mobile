class Tutor {
  Tutor({
    required this.avatar,
    required this.name,
    required this.country,
    required this.feedback,
    required this.introduction,
    required this.liked,
    required this.subjects,
  });

  String avatar;
  String name;
  String country;
  int feedback;
  String introduction;
  bool liked;
  List<String> subjects;
}
