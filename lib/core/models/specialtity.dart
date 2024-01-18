class Speciality {
  String key;
  late String name;

  Speciality({
    required this.key,
  }) {
    name = _formatSpeciality(key);
  }
}

String _formatSpeciality(String speciality) {
  List<String> words = speciality.split('-');
  String formattedSpeciality = words.map((word) => word.capitalize()).join(' ');
  return formattedSpeciality;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
