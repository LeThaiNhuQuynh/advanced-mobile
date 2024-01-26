import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/core/states/user-state.dart';
import 'package:advanced_mobile_project/presentation/course-list/course-list.dart';
import 'package:advanced_mobile_project/presentation/history/history.dart';
import 'package:advanced_mobile_project/presentation/log-in/login_in.dart';
import 'package:advanced_mobile_project/presentation/profile/edit-profile.dart';
import 'package:advanced_mobile_project/presentation/schedule/schedule.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor_list.dart';
import 'package:advanced_mobile_project/services/authencation-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  Menu({super.key});
  AuthenticationService authenticationService = AuthenticationService.instance;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  UserDTO? _userDTO;

  void getUser() async {
    final userProvider = context.read<UserProvider>();
    setState(() {
      _userDTO = userProvider.userDTO;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0071f0),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                'assets/svgs/logo.svg',
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(user: _userDTO!),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      _userDTO!.avatar,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(_userDTO!.name),
                ],
              ),
            ),
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-recurring.svg',
              text: 'Recurring Lesson Schedule',
            ),
            onTap: () {},
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-tutor.svg',
              text: 'Tutor',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TutorList(),
                ),
              );
            },
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-schedule.svg',
              text: 'Schedule',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (Schedule()),
                ),
              );
            },
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-history.svg',
              text: 'History',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => History(),
                ),
              );
            },
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-course.svg',
              text: 'Courses',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseList(),
                ),
              );
            },
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-my-course.svg',
              text: 'My Course',
            ),
            onTap: () {},
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-become-tutor.svg',
              text: 'Become a tutor',
            ),
            onTap: () {},
          ),
          ListTile(
            title: MenuWidget(
              asset: 'assets/svgs/menu-logout.svg',
              text: 'Logout',
            ),
            onTap: () {
              widget.authenticationService.logOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LogIn()));
            },
          ),
        ],
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  MenuWidget({super.key, required this.asset, required this.text});

  String asset;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            color: Color(0xFF0071f0),
            height: 20,
            width: 20,
          ),
          SizedBox(width: 15),
          Text(text),
        ],
      ),
    );
  }
}
