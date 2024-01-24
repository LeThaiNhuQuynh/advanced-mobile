import 'dart:async';

import 'package:advanced_mobile_project/core/dtos/schedule-dto.dart';
import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor-detail-items/booking-dialog.dart';
import 'package:advanced_mobile_project/common/error-dialog.dart';
import 'package:advanced_mobile_project/common/success-dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scheduler extends StatefulWidget {
  final int numsOfDays = 7;
  final DateTime startTime =
      DateTime(TimeOfDay.hoursPerDay).add(const Duration(hours: 0));
  final DateTime endTime =
      DateTime(TimeOfDay.hoursPerDay).add(const Duration(hours: 22));
  late List<DateTime> startTimes;
  final int timeInterval = 30; //minutes
  final int breakTime = 5; //minutes
  final List<ScheduleDTO> schedules;
  final UserDTO? user;
  final void Function() reloadSchedule;

  List<DateTime> generateStartTimes() {
    List<DateTime> results = [];
    DateTime currentTime = startTime.add(const Duration(seconds: 0));
    while (currentTime.isBefore(endTime)) {
      results.add(currentTime);

      currentTime = currentTime.add(const Duration(minutes: 30));
    }
    return results;
  }

  Scheduler(
      {super.key,
      required this.schedules,
      required this.user,
      required this.reloadSchedule}) {
    startTimes = generateStartTimes();
  }

  final ScrollController scrollController = ScrollController();

  @override
  State<Scheduler> createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  late DateTime start;
  late DateTime end;

  List<DateTime> dates = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    start = DateTime.now();
    end = DateTime.now().add(Duration(days: widget.numsOfDays - 1));

    generateDates(start, end);

    _timer = Timer.periodic(
      Duration(days: 1),
      (Timer t) => setState(() {
        start = DateTime.now();
        end = DateTime.now().add(Duration(days: 6));
        dates = [];
        generateDates(start, end);
        // your calculation here
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void generateDates(DateTime start, DateTime end) {
    for (DateTime date = start;
        date.isBefore(end) || date.isAtSameMomentAs(end);
        date = date.add(Duration(days: 1))) {
      dates.add(date);
    }
  }

  List<DataRow> generateTime() {
    List<DataRow> rows = [];
    DateFormat dateFormat = DateFormat('HH:mm');
    for (int i = 0; i < widget.startTimes.length; i++) {
      DateTime startTime = widget.startTimes[i];
      DateTime endTime = startTime.add(const Duration(minutes: 25));
      DataRow row = DataRow(cells: [
        DataCell(Text(
            '${dateFormat.format(startTime)}-${dateFormat.format(endTime)}')),
      ]);
      rows.add(row);
    }
    return rows;
  }

  List<DataRow> generateRows(BuildContext context) {
    List<DataRow> rows = [];
    List<List<DataCell?>> cells = [];

    for (int i = 0; i < widget.startTimes.length; i++) {
      cells.add([]);
      for (int j = 0; j < widget.numsOfDays; j++) {
        cells[i].add(null);
      }
    }

    DateTime now = DateTime.now();
    DateTime currentTime = DateTime(TimeOfDay.hoursPerDay)
        .add(Duration(hours: now.hour, minutes: now.minute));

    isToday(DateTime date) =>
        date.day == now.day && date.month == now.month && date.year == now.year;

    for (ScheduleDTO schedule in widget.schedules) {
      int i = widget.startTimes.indexWhere((element) =>
          element.hour == schedule.startTime.hour &&
          element.minute == schedule.startTime.minute);
      int j = dates.indexWhere((element) =>
          element.day == schedule.date.day &&
          element.month == schedule.date.month &&
          element.year == schedule.date.year);

      if (i != -1 && j != -1) {
        cells[i][j] = schedule.isBooked
            ? schedule.isBooker!
                ? DataCell(Text(
                    'Booked',
                    style: TextStyle(color: Colors.green),
                  ))
                : DataCell(Text(
                    'Reserved',
                    style: TextStyle(color: Colors.grey),
                  ))
            : DataCell(
                TextButton(
                  onPressed: isToday(dates[j])
                      ? currentTime.isBefore(widget.startTimes[i])
                          ? () {
                              DateTime time = DateTime(
                                dates[j].year,
                                dates[j].month,
                                dates[j].day,
                                widget.startTimes[i].hour,
                                widget.startTimes[i].minute,
                              );

                              showDialog(
                                context: context,
                                builder: (context) => BookingDialog(
                                  time: time,
                                  bookingDetailId: schedule.id,
                                  walletAmount: widget.user!.walletAmount,
                                  reloadSchedule: widget.reloadSchedule,
                                ),
                              );
                            }
                          : null // Set to null when currentTime is not before start time
                      : () {
                          DateTime time = DateTime(
                            dates[j].year,
                            dates[j].month,
                            dates[j].day,
                            widget.startTimes[i].hour,
                            widget.startTimes[i].minute,
                          );

                          showDialog(
                            context: context,
                            builder: (context) => BookingDialog(
                              time: time,
                              bookingDetailId: schedule.id,
                              walletAmount: widget.user!.walletAmount,
                              reloadSchedule: widget.reloadSchedule,
                            ),
                          );
                        }, // Default onPressed when it's not today
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF0071f0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: Text(
                    'Book',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
      }
    }

    for (int i = 0; i < widget.startTimes.length; i++) {
      DataRow row = DataRow(
          cells: cells[i].map((e) => e ?? const DataCell(Text(''))).toList());
      rows.add(row);
    }

    return rows;
  }

  List<DataColumn> generateColumns() {
    List<DataColumn> columns = [];
    DateFormat dateFormat = DateFormat('d/M\nE');
    for (DateTime date in dates) {
      columns.add(DataColumn(label: Text(dateFormat.format(date))));
    }

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                'Today',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              onPressed: () {},
            ),
            TextButton(
                child: Text('<'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {}),
            TextButton(
                child: Text('>'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {}),
            Text(DateFormat('MMM, yyyy').format(start)),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SafeArea(
          child: SingleChildScrollView(
              child: Row(
            children: [
              FixedColumnWidget(
                columns: [
                  DataColumn(
                      label: Text(
                    'Time',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ],
                rows: generateTime(),
              ),
              ScrollableColumnWidget(
                columns: generateColumns(),
                rows: generateRows(context),
              ),
            ],
          )),
        )
      ],
    );
  }
}

class FixedColumnWidget extends StatelessWidget {
  final List<DataRow> rows;
  final List<DataColumn> columns;

  const FixedColumnWidget(
      {super.key, required this.rows, required this.columns});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 10,
      headingRowColor: MaterialStateProperty.all(Colors.grey[600]),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      columns: [
        ...columns,
      ],
      rows: [...rows],
    );
  }
}

class ScrollableColumnWidget extends StatelessWidget {
  final List<DataRow> rows;
  final List<DataColumn> columns;

  const ScrollableColumnWidget(
      {super.key, required this.rows, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[600]),
          columnSpacing: 40,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          columns: [...columns],
          rows: [...rows]),
    ));
  }
}
