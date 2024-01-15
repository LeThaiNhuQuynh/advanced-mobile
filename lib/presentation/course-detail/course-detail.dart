import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail-items/course-detail-card.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail-items/title.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail-items/topic.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/course-card.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/multi-select-dropdown.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail({super.key});

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: Header(scaffoldKey: _key),
        endDrawer: Menu(
          userAvatar: 'assets/images/avatar1.jpeg',
          userName: 'User Name',
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CourseDetailCard(
                title: 'Life in the Internet Age',
                description:
                    "Let's discuss how technology is changing the way we live",
              ),
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
                          'Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.',
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
                          'You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.',
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
                  Text('Intermediate',
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
                  Text('9 topics',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                ],
              ),
              SizedBox(height: 20),
              MyTitle(title: 'List topics'),
              SizedBox(height: 20),
              Column(
                children: List.generate(5,
                    (index) => TopicCard(title: 'The internet', index: index)),
              ),
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
