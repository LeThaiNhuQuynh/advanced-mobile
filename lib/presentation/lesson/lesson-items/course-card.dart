import 'package:advanced_mobile_project/core/dtos/course-dto.dart';
import 'package:advanced_mobile_project/presentation/lesson/lesson-items/topic.dart';
import 'package:advanced_mobile_project/presentation/lesson/lesson.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final VoidCallback? onTap;
  final CourseDTO course;

  const CourseCard({
    super.key,
    this.onTap,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<Widget> topiItems = course.topics.map((topic) {
      index++;
      return TopicItem(
        title: topic.name,
        index: index,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Lesson(course: course, topic: topic)));
        },
      );
    }).toList();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/course-card.png',
                  ),
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          course.description,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'List Topics',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            ...topiItems,
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
