import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final int index;

  const TopicCard(
      {super.key, this.onTap, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Text(
                  '$index.\n$title',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ))));
  }
}
