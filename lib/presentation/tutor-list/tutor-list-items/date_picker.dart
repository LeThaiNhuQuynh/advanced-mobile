import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController textController = TextEditingController();
  DateTime date = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != date)
      setState(() {
        date = selected;
        textController.text = "${date.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: 'Select a day',
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today_outlined),
            onPressed: () => _selectDate(context),
          ),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
