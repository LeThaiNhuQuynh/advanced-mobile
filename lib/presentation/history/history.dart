import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/presentation/history/history-items/history-card.dart';
import 'package:advanced_mobile_project/presentation/schedule/schedule-items/schedule-card.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  Tutor1 tutor = Tutor1(
      avatar: 'assets/images/avatar1.jpeg',
      name: "Keegen",
      country: "Philippines",
      feedback: 3,
      introduction:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
      liked: false,
      specialities: [
        'English for kids',
        'English for business',
        'KET',
        'STARTERS',
        'PET',
        'English for business',
        'Conversational',
        'STARTERS'
      ],
      education: 'BA',
      languages: ['English', 'Filipino'],
      interests:
          ' I loved the weather, the scenery and the laid-back lifestyle of the locals.',
      experience: 'I have more than 10 years of teaching english experience',
      feedbacks: [
        Comment(
          tutor: Tutor1(
              avatar: 'assets/images/avatar1.jpeg',
              name: "Another",
              country: "Vietnam",
              feedback: 0,
              introduction: "introduction",
              liked: false,
              specialities: List.empty(),
              education: "education",
              languages: List.empty(),
              interests: "interests",
              experience: "experience"),
          text: "I have more than 10 years of teaching english experience",
          star: 4,
        )
      ]);

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
            HistoryCard(
              tutor: tutor,
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
