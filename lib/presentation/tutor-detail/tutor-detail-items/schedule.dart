import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 6));
  late List<DateTime> dates;

  @override
  void initState() {
    super.initState();
    dates = [];
    generateDates(start, end);
  }

  void generateDates(DateTime start, DateTime end) {
    for (DateTime date = start;
        date.isBefore(end) || date.isAtSameMomentAs(end);
        date = date.add(Duration(days: 1))) {
      dates.add(date);
    }
  }

  List<DataRow> generateRows() {
    List<DataRow> rows = [];

    DateTime currentTime = DateTime(TimeOfDay.hoursPerDay);
    DateTime endTime = currentTime.add(Duration(hours: 24));
    DateFormat dateFormat = DateFormat('HH:mm');

    while (currentTime.isBefore(endTime)) {
      DateTime startTime = currentTime.add(const Duration(seconds: 0));
      DateTime endTime = startTime.add(const Duration(minutes: 25));

      DataRow row = DataRow(cells: [
        DataCell(Text(
            '${dateFormat.format(currentTime)}-${dateFormat.format(endTime)}')),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
        DataCell(TextButton(
          onPressed: () {},
          child: Text(
            'Booked',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        )),
      ]);
      rows.add(row);
      currentTime = currentTime.add(Duration(minutes: 30));
    }

    return rows;
  }

  List<DataColumn> generateColumns() {
    List<DataColumn> columns = [];
    DateFormat dateFormat = DateFormat('d/M\nE');
    columns.add(DataColumn(label: Text('')));
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: generateColumns(),
            rows: generateRows(),
          ),
        ),
      ],
    );
  }
}
