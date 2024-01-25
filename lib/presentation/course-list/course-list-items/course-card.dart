import 'package:advanced_mobile_project/core/dtos/course-dto.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/image-in-card.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/level-controller.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final VoidCallback? onTap;
  final CourseDTO course;

  const CourseCard({super.key, this.onTap, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      course.imageUrl,
                      fit: BoxFit.cover,
                    ),
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
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            Level.getLevel(course.level) +
                                " - " +
                                course.topics.length.toString() +
                                ' Lessons',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
