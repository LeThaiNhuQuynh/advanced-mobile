import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  MyTitle({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        Container(
          width: 150,
          height: 0.5,
          color: Colors.grey[400],
          margin: EdgeInsets.only(left: 12),
        ),
      ],
    );
  }
}
