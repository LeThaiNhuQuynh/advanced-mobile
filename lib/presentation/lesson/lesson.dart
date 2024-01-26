import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/core/dtos/course-dto.dart';
import 'package:advanced_mobile_project/core/dtos/topic-dto.dart';
import 'package:advanced_mobile_project/presentation/lesson/lesson-items/carousel.dart';
import 'package:advanced_mobile_project/presentation/lesson/lesson-items/course-card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Lesson extends StatelessWidget {
  Lesson({super.key, required this.course, required this.topic});

  final CourseDTO course;
  final TopicDTO topic;

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: Header(scaffoldKey: _key),
        endDrawer: Menu(),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CourseCard(course: course),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: SfPdfViewer.network(
                      topic.nameFile,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
