class FilterItemDTO {
  int? id;
  String key;
  String name;

  FilterItemDTO({
    this.id,
    required this.key,
    required this.name,
  });

  static FilterItemDTO fromJson(speciality) {
    return FilterItemDTO(name: speciality["name"], key: speciality["key"]);
  }
}
