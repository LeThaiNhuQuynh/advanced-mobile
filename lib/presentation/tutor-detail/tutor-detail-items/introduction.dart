import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {
  Introduction({Key? key, required this.introduction}) : super(key: key);

  String introduction;

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            showFullText
                ? widget.introduction
                : (widget.introduction.length > 100
                    ? widget.introduction.substring(0, 100) + "..."
                    : widget.introduction),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200,
              color: Colors.black,
              fontSize: 15,
              letterSpacing: 0.75,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          if (widget.introduction.length > 100)
            GestureDetector(
              onTap: () {
                setState(() {
                  showFullText = !showFullText;
                });
              },
              child: Text(
                showFullText ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
