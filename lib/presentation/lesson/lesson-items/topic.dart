import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final int index;

  const TopicItem(
      {super.key, this.onTap, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(12),
            child: Text(
              '$index.     $title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )));
  }
}
