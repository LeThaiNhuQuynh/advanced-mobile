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
                  Row(
                    children: [
                      Text(
                        commentDTO.name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[800],
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        formatDuration(commentDTO.updatedAt),
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[400],
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
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
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
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

  String formatDuration(DateTime updatedDate) {
    Duration duration = DateTime.now().difference(updatedDate);

    if (duration.inDays > 0) {
      if (duration.inDays == 1) {
        return 'a day ago';
      }
      return '${duration.inDays} days ago';
    } else if (duration.inHours > 0) {
      if (duration.inHours == 1) {
        return 'an hour ago';
      }
      return '${duration.inHours} hours ago';
    } else if (duration.inMinutes > 0) {
      if (duration.inMinutes == 1) {
        return 'a minute ago';
      }
      return '${duration.inMinutes} minutes ago';
    } else {
      if (duration.inSeconds <= 0) {
        return 'just now';
      }
      if (duration.inSeconds == 1) {
        return 'a second ago';
      }
      return '${duration.inSeconds} seconds ago';
    }
  }
}
