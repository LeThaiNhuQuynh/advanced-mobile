import 'package:advanced_mobile_project/common/avatar.dart';
import 'package:advanced_mobile_project/common/skill_item.dart';
import 'package:advanced_mobile_project/core/dtos/detail-tutor-dto.dart';
import 'package:advanced_mobile_project/core/dtos/filter-item-dto.dart';
import 'package:advanced_mobile_project/core/dtos/general-tutor-dto.dart';
import 'package:advanced_mobile_project/core/models/specialtity.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/presentation/tutor-detail/tutor_detail.dart';
import 'package:advanced_mobile_project/services/tutor-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorCard extends StatefulWidget {
  TutorCard({super.key, required this.tutor});

  TutorService tutorService = TutorService.instance;
  GeneralTutorDTO tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  DetailTutorDTO detailTutorDTO = DetailTutorDTO(
    id: "0",
    name: "",
    avatar: "",
    country: "",
    bio: "",
    rating: 0,
    isFavorite: false,
    specialties: "hehe",
    video: "",
    education: "",
    experience: "",
    interests: "",
    languages: "",
    totalFeedbacks: 0,
    courses: [],
    // detailSpecialties: []
  );

  void onFavorite() async {
    Map res = await widget.tutorService.favoriteTutor(widget.tutor.id);

    if (res["status"] == "200") {
      setState(() {
        widget.tutor.isFavorite = !widget.tutor.isFavorite;
      });
    } else if (res["status"] == "401") {
      Navigator.pushNamed(context, '/login');
    }
  }

  Future<void> getDetailTutor() async {
    Map response = await widget.tutorService.getTutorById(widget.tutor.id);

    if (response["status"] == "200") {
      setState(() {
        detailTutorDTO = response["tutor"];
      });
    } else if (response["status"] == "401" && context.mounted) {
      print(response["message"]);
    } else {
      print(response["message"]);
    }
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

    return Container(
        margin: EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () async {
              await getDetailTutor();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TutorDetail(tutor: detailTutorDTO)));
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
                      onTap: () {
                        onFavorite();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Avatar(
                            radius: 40,
                            avatarText: widget.tutor.name,
                            imageUrl: widget.tutor.avatar ??
                                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          ),
                          widget.tutor.isFavorite
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
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(children: filterWidgets),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 100,
                      child: Text(
                        widget.tutor.bio,
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             TutorDetail(tutor: widget.tutor)));
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
