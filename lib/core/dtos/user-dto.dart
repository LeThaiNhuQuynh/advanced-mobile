import 'package:advanced_mobile_project/core/dtos/subject-dto.dart';

class UserDTO {
  String id;
  String email;
  String name;
  String avatar;
  String country;
  String phone;
  String birthday;
  List<String> roles;
  String studySchedule;
  late String avatarText;
  String level;
  List<SubjectDTO> learnTopics;
  List<SubjectDTO> testPreparations;
  int timezone;
  int walletAmount;

  UserDTO({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.birthday,
    required this.roles,
    required this.studySchedule,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.timezone,
    required this.walletAmount,
  }) {
    avatarText = '';
    if (name.isNotEmpty) {
      avatarText += name[0];
    }
    if (name.length > 1 && name[1].isNotEmpty) {
      avatarText += name[1];
    }
  }

  static UserDTO fromJson(user) {
    String amountString = user['walletInfo']['amount'];

    return UserDTO(
      id: user['id'],
      email: user['email'],
      name: user['name'],
      avatar: user['avatar'],
      country: user['country'] ?? '',
      phone: user['phone'],
      birthday: user['birthday'] ?? '',
      roles: user['roles'].cast<String>(),
      studySchedule: user['studySchedule'] ?? '',
      level: user['level'] ?? '',
      timezone: user['timezone'] ?? 0,
      walletAmount: int.parse(amountString.replaceAll(RegExp(r'0*$'), '')),
      learnTopics: user['learnTopics']
          .map<SubjectDTO>((e) => SubjectDTO.fromJson(e))
          .toList(),
      testPreparations: user['testPreparations']
          .map<SubjectDTO>((e) => SubjectDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'country': country,
      'phone': phone,
      'birthday': birthday,
      'roles': roles,
      'studySchedule': studySchedule,
      'level': level,
      'learnTopics': learnTopics.map((e) => e.toJson()).toList(),
      'testPreparations': testPreparations.map((e) => e.toJson()).toList(),
      'timezone': timezone,
      'walletInfo': {'amount': walletAmount.toString()},
    };
  }
}
