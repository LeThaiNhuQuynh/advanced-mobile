import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final BorderRadius? borderRadius;
  final String? errorText;
  final EdgeInsetsGeometry? padding;
  final bool isRequired;
  final void Function(String) onChanged;
  final String? Function(String)? validator;
  final void Function(String)? onError;

  const DatePicker(
      {super.key,
      required this.controller,
      required this.onChanged,
      this.label,
      this.borderRadius,
      this.errorText,
      this.padding,
      this.isRequired = false,
      this.validator,
      this.onError});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController get controller => widget.controller;

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (context.mounted) {
          controller.text = "${selectedDate.toLocal()}".split(' ')[0];
          widget.onChanged(controller.text);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onTap: () {
          _selectDate(context);
        },
        onChanged: widget.onChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
