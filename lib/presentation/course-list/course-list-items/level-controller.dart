class Level {
  static String getLevel(int level) {
    switch (level) {
      case 1:
        return "Beginner";
      case 4:
        return "Intermediate";
      case 7:
        return "Advanced";
      default:
        return "Any level";
    }
  }

  List<String> all() {
    return [
      "Beginner",
      "Higher Beginner",
      "Pre-Intermediate",
      "Intermediate",
      "Upper-Intermediate",
      "Advanced",
      "Proficiency",
      "High Beginner",
      "Any level"
    ];
  }
}
