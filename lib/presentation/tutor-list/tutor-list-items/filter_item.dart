import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String content;
  final VoidCallback? selected;

  const FilterItem({
    super.key,
    required this.content,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(4),
        child: TextButton(
          onPressed: selected,
          style: TextButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            content,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200,
                color: Colors.black,
                fontSize: 15),
          ),
        ));
  }
}
