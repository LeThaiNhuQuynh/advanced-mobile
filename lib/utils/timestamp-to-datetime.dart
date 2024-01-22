class TimestampToDateTime {
  static DateTime transfer(int timestamp, {int timezone = 0}) {
    int timestampInMillis = timestamp;
    int timestampInSeconds = timestampInMillis ~/ 1000;

    DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(
        timestampInSeconds * 1000,
        isUtc: true);

    DateTime localDateTime = utcDateTime.add(Duration(hours: timezone));

    return localDateTime;
  }
}
