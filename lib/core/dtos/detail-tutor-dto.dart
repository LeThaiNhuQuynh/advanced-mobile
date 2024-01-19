import 'package:advanced_mobile_project/core/dtos/general-tutor-dto.dart';

class DetailTutorDTO extends GeneralTutorDTO {
  String video;
  String education;
  String experience;
  String interests;
  String languages;
  int totalFeedbacks;
  List<String>? courses;

  DetailTutorDTO(
      {required super.id,
      required super.name,
      required super.avatar,
      required super.country,
      required super.bio,
      required super.rating,
      required super.isFavorite,
      super.specialties,
      required this.video,
      required this.education,
      required this.experience,
      required this.interests,
      required this.languages,
      required this.totalFeedbacks,
      this.courses});

  static DetailTutorDTO fromJson(tutor) {
    List<String> courses = [];
    if (tutor["User"]["courses"] != null) {
      courses = tutor["User"]["courses"]
          .map((course) => course["name"])
          .cast<String>()
          .toList();
    }
    return DetailTutorDTO(
      id: tutor["User"]["id"],
      name: tutor["User"]["name"],
      avatar: tutor["User"]["avatar"],
      country: tutor["User"]["country"],
      bio: tutor["bio"],
      specialties: tutor["specialties"],
      rating: tutor["rating"] == null ? 0 : tutor["rating"].round(),
      isFavorite: tutor["isFavorite"],
      video: tutor["video"],
      education: tutor["education"],
      experience: tutor["experience"],
      interests: tutor["interests"],
      languages: tutor["languages"],
      totalFeedbacks: tutor["totalFeedback"] ?? 0,
      courses: courses,
    );
  }
}
