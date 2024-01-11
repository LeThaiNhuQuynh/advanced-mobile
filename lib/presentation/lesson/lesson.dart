import 'package:advanced_mobile_project/presentation/lesson/lesson-items/carousel.dart';
import 'package:advanced_mobile_project/presentation/lesson/lesson-items/course-card.dart';
import 'package:flutter/material.dart';

class Lesson extends StatelessWidget {
  const Lesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: MyAppBar(),
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CourseCard(
                  title: 'Life in the Internet Age',
                  description:
                      "Let's discuss how technology is changing the way we live",
                  detail: 'detail'),
              SizedBox(height: 20),
              Carousel(),
            ],
          ),
        ),
      ]),
    ));
  }
}
