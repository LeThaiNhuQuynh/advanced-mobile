import 'package:advanced_mobile_project/common/skill_item.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorCard extends StatefulWidget {
  TutorCard({super.key, required this.tutor});

  Tutor tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> filterWidgets = widget.tutor.subjects.map((String item) {
      return SkillItem(content: item);
    }).toList();

    return Container(
        margin: EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TutorDetail(tutor: widget.tutor)));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: widget.tutor.liked
                          ? () {
                              setState(() {
                                widget.tutor.liked = false;
                              });
                            }
                          : () {
                              setState(() {
                                widget.tutor.liked = true;
                              });
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(widget.tutor.avatar),
                          ),
                          widget.tutor.liked
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
                        ],
                      ),
                    ),
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
                                fontSize: 24),
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
                              widget.tutor.country,
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
                                  index < widget.tutor.feedback
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
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(children: filterWidgets),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 100,
                      child: Text(
                        widget.tutor.introduction,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 0.75,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                color: Color(
                                    0xFF0071f0), // Set your desired border color here
                                width: 2.0, // Set the border width
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TutorDetail(tutor: widget.tutor)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/book.svg',
                                  color: Color(0xFF0071f0),
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Book',
                                  style: TextStyle(
                                    color: Color(0xFF0071f0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
