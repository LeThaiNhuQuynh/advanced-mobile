import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:advanced_mobile_project/core/models/feedback.dart';
import 'package:advanced_mobile_project/core/models/specialtity.dart';

class Tutor1 {
  Tutor1({
    required this.avatar,
    required this.name,
    required this.country,
    required this.feedback,
    required this.introduction,
    required this.liked,
    required this.specialities,
    required this.education,
    required this.languages,
    required this.interests,
    required this.experience,
    this.feedbacks = const [],
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
  List<String> specialities;
  List<String> languages;
  List<Comment> feedbacks = List.empty();

  // int getRating() {
  //   double sum = 0;
  //   for (var feedback in feedbacks) {
  //     sum += feedback.rating;
  //   }
  //   return (sum / feedbacks.length).round();
  // }
}
