import 'package:advanced_mobile_project/common/footer.dart';
import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/core/dtos/filter-item-dto.dart';
import 'package:advanced_mobile_project/core/dtos/class-dto.dart';
import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/core/models/general-tutor.dart';
import 'package:advanced_mobile_project/core/states/user-state.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor_detail.dart';
import 'package:advanced_mobile_project/common/pagination.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor-list-items/tutor_card.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor-list-items/upcoming-lesson-banner.dart';
import 'package:advanced_mobile_project/services/tutor-service.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../core/dtos/general-tutor-dto.dart';
import '../../core/models/tutor.dart';
import 'tutor-list-items/date_picker.dart';
import 'tutor-list-items/filter_item.dart';
import 'tutor-list-items/time_picker.dart';

class TutorList extends StatefulWidget {
  TutorService tutorService = TutorService.instance;
  UserService userService = UserService.instance;
  final int perPage = 12;

  TutorList({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<TutorList> createState() => _TutorListState();
}

class _TutorListState extends State<TutorList> {
  int totalPage = 1;
  int currentPage = 1;
  String currentFilter = "";
  String searchName = "";
  String noDataMessage = "";
  int _totalLessonHours = 0;
  List<GeneralTutorDTO> tutorList = [];
  List<FilterItemDTO> specialities = [];
  UserDTO? _userDTO;
  ClassDTO? _upcomingClassDTO;
  Duration? _countdownDuration;

  Future<void> getTutorList(int page) async {
    noDataMessage = "";

    Map response = await widget.tutorService
        .geTutorList(widget.perPage, page, currentFilter, searchName);

    if (response["status"] == "200") {
      setState(() {
        totalPage = response["total"];
        tutorList = response["tutors"];
      });
      if (tutorList.isEmpty) {
        noDataMessage = "No data found";
      }
    } else if (response["status"] == "401" && context.mounted) {
      Navigator.pushNamed(context, '/login');
    } else {
      print(response["message"]);
    }

    tutorList.sort((a, b) {
      if (b.isFavorite && !a.isFavorite) {
        return 1;
      } else if (!b.isFavorite && a.isFavorite) {
        return -1;
      }
      return b.rating.compareTo(a.rating);
    });
  }

  Future<void> getSpecialities() async {
    Map response = await widget.tutorService.getFilterItem();

    if (response["status"] == "200") {
      setState(() {
        specialities = response["specialities"];
      });
    } else if (response["status"] == "401" && context.mounted) {
      print(response["message"]);
    } else {
      print(response["message"]);
    }
  }

  Future<void> getTotalLessonHours() async {
    Map response = await widget.userService.getTotalLessonHours();
    if (response["status"] == "200") {
      setState(() {
        _totalLessonHours = response["totalLessonHours"] ?? 0;
      });
    } else if (response["status"] == "401" && context.mounted) {
      print(response["message"]);
    } else {
      print(response["message"]);
    }
  }

  void getUser() async {
    final userProvider = context.read<UserProvider>();
    setState(() {
      _userDTO = userProvider.userDTO;
    });
    getUpcomingClass();
  }

  Future<void> getUpcomingClass() async {
    Map res =
        await widget.userService.getUpcomingLesson(_userDTO?.timezone ?? 0);
    if (res["status"] == "200") {
      setState(() {
        _upcomingClassDTO = res["upcomingClass"];
        _countdownDuration = res["startTime"].difference(DateTime.now());
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

    getUser();
    getTutorList(currentPage);
    getSpecialities();
    getTotalLessonHours();
  }

  @override
  Widget build(BuildContext context) {
    //list of filter items
    List<Widget> filterWidgets = specialities.map((FilterItemDTO item) {
      return FilterItem(
        content: item.name,
        selected: () {
          setState(() {
            currentFilter = item.key;
            getTutorList(1);
          });
        },
      );
    }).toList();

    //list of tutor cards
    List<Widget> tutorWidgets = tutorList.map((GeneralTutorDTO tutor) {
      return TutorCard(tutor: tutor);
    }).toList();

    GlobalKey<ScaffoldState> _key = GlobalKey();
    final TextEditingController _nameController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
          key: _key,
          appBar: Header(scaffoldKey: _key),
          endDrawer: Menu(
            userAvatar: 'assets/images/avatar1.jpeg',
            userName: 'User Name',
          ),
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
            MyBanner(
              totalLessonHours: _totalLessonHours,
              upcomingClassDTO: _upcomingClassDTO,
              countdownDuration: _countdownDuration,
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Find a tutor',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, .9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter tutor name...',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: MultiSelectDropDown(
                            options: const [
                              ValueItem(label: 'Option 1', value: '1'),
                              ValueItem(label: 'Option 2', value: '2'),
                              ValueItem(label: 'Option 3', value: '3'),
                              ValueItem(label: 'Option 4', value: '4'),
                              ValueItem(label: 'Option 5', value: '5'),
                              ValueItem(label: 'Option 6', value: '6'),
                            ],
                            onOptionSelected:
                                (List<ValueItem> selectedOptions) {},
                            hint: 'Select tutor nation',
                            borderRadius: 50.0,
                            borderColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF0071f0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(
                          color: Color(0xFF0071f0),
                          width: 2.0, // Set the border width
                        ),
                      ),
                      onPressed: () {
                        String enteredText = _nameController.text;
                        setState(() {
                          searchName = enteredText;
                          getTutorList(1);
                        });
                      },
                      child: const Text(
                        'Find',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Set available tutoring time',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, .9),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 180,
                      child: DatePicker(),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        SizedBox(
                          width: 170,
                          child: TimePicker(displayText: "Start time"),
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          width: 150,
                          child: TimePicker(displayText: "End time"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(children: filterWidgets),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 40,
                      width: 140,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(
                            color: Color(0xFF0071f0),
                            width: 2.0, // Set the border width
                          ),
                        ),
                        onPressed: () {
                          // do nothing
                        },
                        child: const Text(
                          'Reset Filters',
                          style: TextStyle(
                            color: Color(0xFF0071f0),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: noDataMessage == ""
                          ? tutorWidgets
                          : [
                              Text(
                                noDataMessage,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, .9),
                                ),
                              ),
                            ],
                    ),
                    const SizedBox(height: 30),
                    if (totalPage != null)
                      Pagination(
                        totalPage: totalPage!,
                        onPageChange: (int page) {
                          getTutorList(page);
                        },
                      ),
                  ],
                )),
            Footer()
          ]))),
    );
  }
}
