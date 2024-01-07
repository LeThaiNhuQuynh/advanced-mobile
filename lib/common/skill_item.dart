import 'package:flutter/material.dart';

class SkillItem extends StatelessWidget {
  final String content;

  const SkillItem({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(4),
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(0, 113, 240, 0.2),
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
                fontWeight: FontWeight.w300,
                color: Color(0xFF0071f0),
                fontSize: 15),
          ),
        ));
  }
}
