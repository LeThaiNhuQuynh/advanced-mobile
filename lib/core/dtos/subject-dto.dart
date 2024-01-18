class SubjectDTO {
  final String id;
  final String name;
  final String key;

  SubjectDTO({
    required this.id,
    required this.name,
    required this.key,
  });

  static SubjectDTO fromJson(decodedResponse) {
    return SubjectDTO(
      id: decodedResponse['id'].toString(),
      name: decodedResponse['name'],
      key: decodedResponse['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "key": key,
    };
  }
}
