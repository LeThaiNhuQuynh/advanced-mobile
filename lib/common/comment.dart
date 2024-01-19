import 'package:advanced_mobile_project/common/avatar.dart';
import 'package:advanced_mobile_project/core/dtos/comment-dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({Key? key, required this.commentDTO}) : super(key: key);

  CommentDTO commentDTO;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Avatar(
          radius: 20,
          avatarText: commentDTO.name,
          imageUrl: commentDTO.avatar ??
              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentDTO.name,
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
                          index < commentDTO.rating
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
                      commentDTO.content,
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
