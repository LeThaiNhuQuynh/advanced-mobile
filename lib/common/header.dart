import 'package:advanced_mobile_project/presentation/tutor-list/tutor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var logoIcon = Container(
      margin: const EdgeInsets.only(left: 10),
      child: SvgPicture.asset(
        'assets/svgs/logo.svg',
        width: 35,
        height: 35,
      ),
    );

    var languageIcon = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(158, 158, 158, 1).withOpacity(0.4),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: SvgPicture.asset(
              'assets/svgs/nation.svg',
              width: 25,
              height: 25,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: SvgPicture.asset(
                'assets/svgs/menu.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
        SizedBox(width: 20)
      ],
    );

    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: Container(
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.3,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TutorList(),
                  ),
                )
              },
              child: logoIcon,
            ),
            SizedBox(width: screenWidth - 300),
            languageIcon,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
