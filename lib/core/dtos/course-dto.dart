import 'package:advanced_mobile_project/core/dtos/topic-dto.dart';

class CourseDTO {
  String id;
  String name;
  String description;
  String imageUrl;
  int level;
  String category;
  String reason;
  String purpose;
  List<TopicDTO> topics;

  CourseDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.category,
    required this.reason,
    required this.purpose,
    required this.topics,
  });

  static CourseDTO fromJson(json) {
    String category =
        json['catehories'] == null ? "" : json['categories'].first['title'];
    return CourseDTO(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: int.parse(json['level']),
      reason: json['reason'],
      purpose: json['purpose'],
      category: category,
      topics: json['topics']
          .map<TopicDTO>((topic) => TopicDTO(
                id: topic['id'],
                name: topic['name'],
                description: topic['description'],
                nameFile: topic['nameFile'],
              ))
          .toList(),
    );
  }
}
