import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/course-card.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/multi-select-dropdown.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseList extends StatelessWidget {
  CourseList({super.key});

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
          child: Column(children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SvgPicture.asset(
                    'assets/svgs/course-list.svg',
                    height: 140,
                    width: 140,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover\nCourses',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                ),
                                child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'E-Books',
                                    ),
                                    onChanged: (String value) {})),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                ),
                              ),
                              child: TextButton(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {})),
                        ],
                      ),
                    ],
                  )),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Wrap(
                      children: [
                        Text(
                          'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: MyMultiSelectDropDown(
                            hint: 'Select Level',
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: MyMultiSelectDropDown(
                            hint: 'Select category',
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 12),
                          child: MyMultiSelectDropDown(
                            hint: 'Sort by level',
                          )),
                    ]),
                  ],
                ),
              ],
            )),
        SizedBox(
          height: 700,
          child: MyTabBar(quantity: 3, tabs: [
            Tab(child: Text('Courses')),
            Tab(child: Text('E-books')),
            Tab(child: Text('Interative E-books')),
          ], views: [
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetail(),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: CourseCard(
                          title: 'Life in the Internet Age',
                          description:
                              "Let's discuss how technology is changing the way we live",
                          detail: '9 lessons',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text("No Data"),
            ),
            Center(
              child: Text("No Data"),
            ),
          ]),
        ),
      ])),
    );
  }
}
