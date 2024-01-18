class SpecialityDTO {
  late List<String> specialties;

  SpecialityDTO(String specialtiesString) {
    this.specialties = _parseSpecialties(specialtiesString);
  }

  List<String> _parseSpecialties(String specialtiesString) {
    List<String> specialtiesList = specialtiesString.split(',');
    return specialtiesList.map((spec) => _formatSpeciality(spec)).toList();
  }

  String _formatSpeciality(String speciality) {
    List<String> words = speciality.split('-');
    String formattedSpeciality =
        words.map((word) => word.capitalize()).join(' ');
    return formattedSpeciality;
  }

  List<String> getListString() {
    return specialties;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
