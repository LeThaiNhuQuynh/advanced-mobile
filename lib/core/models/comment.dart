import 'package:advanced_mobile_project/core/models/tutor.dart';

class Comment {
  Comment({
    required this.tutor,
    required this.star,
    required this.text,
  });

  Tutor tutor;
  int star;
  String text;
}
