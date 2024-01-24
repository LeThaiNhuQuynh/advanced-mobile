class UpcomingClassDTO {
  String date;
  String time;
  String tutorId;
  String userId;
  String token;

  UpcomingClassDTO(
      {required this.date,
      required this.time,
      required this.tutorId,
      required this.userId,
      required this.token});
}
