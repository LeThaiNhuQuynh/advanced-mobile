import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/common/pagination.dart';
import 'package:advanced_mobile_project/core/dtos/course-dto.dart';
import 'package:advanced_mobile_project/presentation/course-detail/course-detail.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/course-card.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/multi-select-dropdown.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list-items/tab-bar.dart';
import 'package:advanced_mobile_project/services/course-service.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseList extends StatefulWidget {
  CourseService courseService = CourseService.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  int _currentPage = 1;
  int _totalPages = 1;
  Map<String, List<CourseDTO>> _coursesByCategory = {};
  String _findContent = "";

  final ScrollController _scrollController = ScrollController();

  Future<void> getCourseList(int page) async {
    Map res = await widget.courseService.getListCourses(page);
    if (res["status"] == "200") {
      setState(() {
        _coursesByCategory = res["coursesByCategory"];
        _totalPages = res["total"];
      });
    } else if (res["status"] == "401") {
      if (context.mounted) {
        print(res["message"]);
      }
    }
  }

  Future<void> findCourse(String content) async {
    Map res = await widget.courseService.findCourses(content);
    if (res["status"] == "200") {
      setState(() {
        _coursesByCategory = res["coursesByCategory"];
        _totalPages = res["total"];
      });
    } else if (res["status"] == "401") {
      if (context.mounted) {
        print(res["message"]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCourseList(_currentPage);
  }

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
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                ),
                                child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Course',
                                    ),
                                    onChanged: (String value) {
                                      _findContent = value;
                                    })),
                          ),
                          Container(
                              height: 40,
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
                                  onPressed: () {
                                    findCourse(_findContent);
                                  })),
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
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: _coursesByCategory.entries
                      .map((entry) => CategoryTile(entry.key, entry.value))
                      .toList(),
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
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_totalPages != null)
              Pagination(
                totalPage: _totalPages!,
                onPageChange: (int page) {
                  getCourseList(page);
                },
              ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ])),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String category;
  final List<CourseDTO> courses;

  CategoryTile(this.category, this.courses);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            category,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        for (var course in courses)
          CourseCard(
            course: course,
          ),
      ],
    );
  }
}
