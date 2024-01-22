class ScheduleDTO {
  final String id;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;
  final bool? isBooker;

  ScheduleDTO({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    this.isBooker,
  });
}
