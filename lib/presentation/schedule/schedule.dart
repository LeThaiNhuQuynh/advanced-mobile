import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/core/dtos/class-dto.dart';
import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/core/states/user-state.dart';
import 'package:advanced_mobile_project/presentation/schedule/schedule-items/schedule-card.dart';
import 'package:advanced_mobile_project/common/pagination.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  UserService userService = UserService.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  int _currentPage = 1;
  int _totalPages = 1;
  UserDTO? _userDTO;
  List<ClassDTO> _upcomingClassDTO = [];

  void getUser() async {
    final userProvider = context.read<UserProvider>();
    setState(() {
      _userDTO = userProvider.userDTO;
    });
    getClassList(_currentPage);
  }

  Future<void> getClassList(int page) async {
    Map res =
        await widget.userService.getClassList(_userDTO?.timezone ?? 0, page);
    if (res["status"] == "200") {
      setState(() {
        _upcomingClassDTO = res["classList"];
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
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> scheduleCards = _upcomingClassDTO.map((ClassDTO item) {
      return ScheduleCard(
        classDTO: item,
        reloadList: () {
          setState(() {
            getClassList(_currentPage);
          });
        },
      );
    }).toList();

    return Scaffold(
      key: _key,
      appBar: Header(scaffoldKey: _key),
      endDrawer: Menu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.calendar_month,
                        color: Color(0xFF0071f0),
                        size: 160,
                      ),
                    ]),
                    Row(
                      children: [
                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 36,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    'Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: scheduleCards,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_totalPages != null)
                  Pagination(
                    totalPage: _totalPages!,
                    onPageChange: (int page) {
                      getClassList(page);
                    },
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
