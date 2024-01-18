abstract class User {
  String id;
  String name;
  String email;
  String country;
  String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    this.avatar,
  });
}
