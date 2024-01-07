import 'package:advanced_mobile_project/core/models/comment.dart';

class Tutor {
  Tutor({
    required this.avatar,
    required this.name,
    required this.country,
    required this.feedback,
    required this.introduction,
    required this.liked,
    required this.subjects,
    required this.education,
    required this.languages,
    required this.interests,
    required this.experience,
    this.comments = const [],
  });

  String avatar;
  String name;
  String country;
  int feedback;
  String introduction;
  String education;
  String interests;
  String experience;
  bool liked;
  List<String> subjects;
  List<String> languages;
  List<Comment> comments = List.empty();
}
