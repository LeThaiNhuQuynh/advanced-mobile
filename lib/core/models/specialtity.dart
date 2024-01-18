class Speciality {
  static int _idCounter = 0;

  late int id;
  String name;

  Speciality({
    required this.name,
  }) {
    id = _idCounter++;
  }
}
