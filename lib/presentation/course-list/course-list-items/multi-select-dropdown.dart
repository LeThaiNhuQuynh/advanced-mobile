import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MyMultiSelectDropDown extends StatelessWidget {
  MyMultiSelectDropDown({super.key, required this.hint});

  String hint;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      options: const [
        ValueItem(label: 'Option 1', value: '1'),
        ValueItem(label: 'Option 2', value: '2'),
        ValueItem(label: 'Option 3', value: '3'),
        ValueItem(label: 'Option 4', value: '4'),
        ValueItem(label: 'Option 5', value: '5'),
        ValueItem(label: 'Option 6', value: '6'),
      ],
      onOptionSelected: (List<ValueItem> selectedOptions) {},
      hint: hint,
      borderRadius: 50.0,
      borderColor: Colors.black,
    );
  }
}
