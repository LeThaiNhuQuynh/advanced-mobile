import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final String displayText;

  const TimePicker({Key? key, required this.displayText}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerInputState();
}

class _TimePickerInputState extends State<TimePicker> {
  TimeOfDay startTime = TimeOfDay.now();
  TextEditingController textStartController = TextEditingController();

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selected = await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              startTime.hour,
              startTime.minute,
            ),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                startTime = TimeOfDay.fromDateTime(newDateTime);
                textStartController.text = startTime.format(context);
              });
            },
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        startTime = selected;
        textStartController.text = startTime.format(context);
      });
    }
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Flexible(
            child: TextField(
              controller: textStartController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: widget.displayText,
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () => _selectStartTime(context),
                ),
              ),
              onTap: () => _selectStartTime(context),
            ),
          ),
        ],
      ),
    );
  }
}
