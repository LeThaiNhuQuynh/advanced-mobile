import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/core/dtos/course-dto.dart';
import 'package:advanced_mobile_project/core/dtos/topic-dto.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail-items/course-detail-card.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail-items/title.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail-items/topic.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/course-card.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/level-controller.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/multi-select-dropdown.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../lesson/lesson.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail({super.key, required this.course});

  GlobalKey<ScaffoldState> _key = GlobalKey();
  CourseDTO course;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<Widget> topicCards = course.topics.map((TopicDTO item) {
      index++;
      return TopicCard(
        topic: item,
        index: index,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Lesson(course: course, topic: item)));
        },
      );
    }).toList();

    return Scaffold(
        key: _key,
        appBar: Header(scaffoldKey: _key),
        endDrawer: Menu(),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CourseDetailCard(course: course),
              SizedBox(height: 20),
              MyTitle(title: 'Overview'),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 5),
                    child: Icon(
                      Icons.help_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why Take This Course?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          course.reason,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 5),
                    child: Icon(
                      Icons.help_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What will you be able to do',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          course.purpose,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MyTitle(title: 'Experience Level'),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.people_alt_outlined, color: Color(0xFF0071f0)),
                  SizedBox(width: 20),
                  Text(Level.getLevel(course.level),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                ],
              ),
              SizedBox(height: 20),
              MyTitle(title: 'Course length'),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.class_, color: Color(0xFF0071f0)),
                  SizedBox(width: 20),
                  Text('${course.topics.length} topics',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                ],
              ),
              SizedBox(height: 20),
              MyTitle(title: 'List topics'),
              SizedBox(height: 20),
              Column(children: topicCards),
              SizedBox(height: 20),
              MyTitle(title: 'Suggested Tutors'),
              Row(
                children: [
                  Text(
                    'Keegan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TextButton(
                      child: Text(
                        'More infor',
                        style: TextStyle(
                            color: Color(0xFF0071f0),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {})
                ],
              )
            ],
          ),
        )));
  }
}
