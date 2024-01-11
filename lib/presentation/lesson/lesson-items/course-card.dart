import 'package:advanced_mobile_project/presentation/lesson/lesson-items/topic.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String description;
  final String detail;

  const CourseCard(
      {super.key,
      this.onTap,
      required this.title,
      required this.description,
      required this.detail});

  @override
  Widget build(BuildContext context) {
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
                          title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          description,
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
                        ...List.generate(
                            10,
                            (index) => Column(
                                  children: [
                                    TopicItem(
                                        title: 'The Internet', index: index),
                                  ],
                                )),
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
