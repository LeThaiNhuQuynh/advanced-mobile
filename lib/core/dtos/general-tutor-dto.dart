import 'package:advanced_mobile_project/core/models/specialtity.dart';

class GeneralTutorDTO {
  String id;
  String name;
  String? avatar;
  String? country;
  String bio;
  String? specialties;
  int rating;
  bool isFavorite;

  GeneralTutorDTO(
      {required this.id,
      required this.name,
      required this.avatar,
      required this.country,
      required this.bio,
      required this.specialties,
      required this.rating,
      required this.isFavorite});

  static GeneralTutorDTO fromJson(tutor) {
    return GeneralTutorDTO(
        id: tutor["id"],
        name: tutor["name"],
        avatar: tutor["avatar"],
        country: tutor["country"],
        bio: tutor["bio"],
        specialties: tutor["specialties"],
        rating: tutor["rating"] == null ? 0 : tutor["rating"].round(),
        isFavorite: tutor["isFavoriteTutor"] != null);
  }
}
