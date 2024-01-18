import 'package:advanced_mobile_project/core/models/specialtity.dart';
import 'package:advanced_mobile_project/core/models/user.dart';

class GeneralTutor extends User {
  String bio;
  List<Speciality>? specialities;
  int rating;
  bool isFavorite;

  GeneralTutor(
      {required super.id,
      required super.name,
      required super.email,
      required super.country,
      required this.bio,
      required this.rating,
      required this.isFavorite,
      super.avatar,
      this.specialities});
}
