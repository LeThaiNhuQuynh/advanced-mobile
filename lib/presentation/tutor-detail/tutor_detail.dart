import 'package:advanced_mobile_project/common/comment.dart';
import 'package:advanced_mobile_project/common/footer.dart';
import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/common/skill_item.dart';
import 'package:advanced_mobile_project/core/dtos/comment-dto.dart';
import 'package:advanced_mobile_project/core/dtos/detail-tutor-dto.dart';
import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:advanced_mobile_project/core/models/specialtity.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor-detail-items/introduction.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor-detail-items/schedule.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor-detail-items/video.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor_list.dart';
import 'package:advanced_mobile_project/services/tutor-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/avatar.dart';
import '../../core/dtos/filter-item-dto.dart';
import '../tutor-list/tutor-list-items/filter_item.dart';

class TutorDetail extends StatefulWidget {
  TutorDetail({super.key, required this.tutor});

  TutorService tutorService = TutorService.instance;
  DetailTutorDTO tutor;

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  State<TutorDetail> createState() => _TutorDetailState();
}

class _TutorDetailState extends State<TutorDetail> {
  List<CommentDTO> _comments = [];
  int _totalPageComments = 1;

  void onFavorite() async {
    Map res = await widget.tutorService.favoriteTutor(widget.tutor.id);

    if (res["status"] == "200") {
      setState(() {
        widget.tutor.isFavorite = !widget.tutor.isFavorite;
      });
    } else if (res["status"] == "401") {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TutorList()),
      );
    }
  }

  Future<void> getComments(int page) async {
    var res = await widget.tutorService.getComments(widget.tutor.id, 12, page);
    if (res["status"] == "200") {
      List<CommentDTO> comments = res["feedbacks"];
      setState(() {
        _comments = comments;
        _totalPageComments = res["total"];
      });
    } else if (res["status"] == "401") {
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TutorList()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getComments(1);
  }

  @override
  Widget build(BuildContext context) {
    List<Speciality> specialities =
        (widget.tutor.specialties?.split(',') ?? []).map((String item) {
      return Speciality(key: item);
    }).toList();

    List<Widget> filterWidgets = specialities.map((Speciality item) {
      return SkillItem(content: item.name);
    }).toList();

    List<Widget> comments = _comments.map((CommentDTO item) {
      return CommentWidget(commentDTO: item);
    }).toList();

    return Scaffold(
      key: widget._key,
      appBar: Header(scaffoldKey: widget._key),
      endDrawer: Menu(
        userAvatar: 'assets/images/avatar1.jpeg',
        userName: 'User Name',
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Avatar(
                    radius: 60,
                    avatarText: widget.tutor.name,
                    imageUrl: widget.tutor.avatar ??
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tutor.name,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 28),
                            ),
                            Row(children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                child: Image.asset(
                                  'assets/images/philippines.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Text(
                                widget.tutor.country ?? '',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ]),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Container(
                                  margin: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    index < widget.tutor.rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                child: Introduction(introduction: widget.tutor.bio),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onFavorite();
                        },
                        child: widget.tutor.isFavorite
                            ? SvgPicture.asset(
                                'assets/svgs/fill-heart.svg',
                                color: Colors.red,
                                width: 30,
                                height: 30,
                              )
                            : SvgPicture.asset(
                                'assets/svgs/no-fill-heart.svg',
                                width: 30,
                                height: 30,
                              ),
                      ),
                      SizedBox(height: 10),
                      widget.tutor.isFavorite
                          ? Text(
                              'Favorite',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.red,
                                  fontSize: 16),
                            )
                          : Text(
                              'Favorite',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF0071f0),
                                  fontSize: 16),
                            ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/report.svg',
                      color: Color(0xFF0071f0),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Chat',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF0071f0),
                          fontSize: 16),
                    ),
                  ],
                ),
              ]),
              SizedBox(height: 30),
              // Video(src: widget.tutor.video),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Education',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      widget.tutor.education ?? '',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Languages',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: SkillItem(
                      content: widget.tutor.languages ?? '',
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Specialities',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Wrap(children: filterWidgets),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Suggested Courses',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Row(children: [
                      Text(
                        'Basic Conversation topics: ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Text(
                        'Link',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF0071f0),
                            fontSize: 18),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 20),
                    child: Row(children: [
                      Text(
                        'Life in the Internet Age:  ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Text(
                        'Link',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF0071f0),
                            fontSize: 18),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 20),
                    child: Row(children: [
                      Text(
                        'Ielts speaking part 3:  ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Text(
                        'Link',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF0071f0),
                            fontSize: 18),
                      ),
                    ]),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Intersts',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      widget.tutor.interests ?? '',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Teaching experience',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      widget.tutor.experience ?? '',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Others review',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ]),
                  Wrap(
                    children: comments,
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Schedule(),
              SizedBox(height: 20),
            ],
          ),
        ),
        const Footer(),
      ])),
    );
  }
}
