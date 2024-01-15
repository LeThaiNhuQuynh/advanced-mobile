import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({Key? key, required this.comment}) : super(key: key);

  Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(comment.tutor.avatar),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.tutor.name,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 4),
                        child: Icon(
                          index < comment.tutor.feedback
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      comment.text,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
