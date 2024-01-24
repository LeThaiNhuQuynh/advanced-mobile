class UpcomingClassDTO {
  String date;
  String time;
  String tutorId;
  String userId;
  String token;
  String? tutorName;
  String? tutorAvatar;
  String? tutorCountry;
  String? scheduleId;

  UpcomingClassDTO(
      {required this.date,
      required this.time,
      required this.tutorId,
      required this.userId,
      required this.token,
      this.tutorName,
      this.tutorAvatar,
      this.tutorCountry,
      this.scheduleId});
}
