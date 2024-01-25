import 'package:advanced_mobile_project/core/dtos/topic-dto.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final VoidCallback? onTap;
  final TopicDTO topic;
  final int index;

  const TopicCard(
      {super.key, this.onTap, required this.index, required this.topic});

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
                  '$index.\n${topic.name}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ))));
  }
}
