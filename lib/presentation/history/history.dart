import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/common/pagination.dart';
import 'package:advanced_mobile_project/core/dtos/class-dto.dart';
import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/core/states/user-state.dart';
import 'package:advanced_mobile_project/presentation/history/history-items/history-card.dart';
import 'package:advanced_mobile_project/presentation/schedule/schedule-items/schedule-card.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  UserService userService = UserService.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  UserDTO? _userDTO;
  List<ClassDTO> _historyClassDTO = [];

  void getUser() async {
    final userProvider = context.read<UserProvider>();
    setState(() {
      _userDTO = userProvider.userDTO;
    });
    getClassList();
  }

  Future<void> getClassList() async {
    Map res = await widget.userService.getHistoryList(_userDTO?.timezone ?? 0);
    if (res["status"] == "200") {
      setState(() {
        _historyClassDTO = res["classList"];
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
    List<Widget> historyCards = _historyClassDTO.map((ClassDTO item) {
      return HistoryCard(
        classDTO: item,
        reloadList: () {
          setState(() {
            getClassList();
          });
        },
      );
    }).toList();

    return Scaffold(
      key: _key,
      appBar: Header(scaffoldKey: _key),
      endDrawer: Menu(
        userAvatar: 'assets/images/avatar1.jpeg',
        userName: 'User Name',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.perm_phone_msg,
                        color: Color(0xFF0071f0),
                        size: 160,
                      ),
                    ]),
                    Row(
                      children: [
                        Text(
                          'History',
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
                                    'The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended',
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
                children: historyCards,
              ),
            ),
            SizedBox(
              height: 20,
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
