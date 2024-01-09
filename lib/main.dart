import 'package:advanced_mobile_project/core/models/comment.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:advanced_mobile_project/presentation/schedule/schedule.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Tutor tutor = Tutor(
      avatar: 'assets/images/avatar1.jpeg',
      name: "Keegen",
      country: "Philippines",
      feedback: 3,
      introduction:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
      liked: false,
      subjects: [
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
      comments: [
        Comment(
          tutor: Tutor(
              avatar: 'assets/images/avatar1.jpeg',
              name: "Another",
              country: "Vietnam",
              feedback: 2,
              introduction: "introduction",
              liked: true,
              subjects: List.empty(),
              education: "education",
              languages: List.empty(),
              interests: "interests",
              experience: "experience"),
          text: "I have more than 10 years of teaching english experience",
          star: 4,
        )
      ]);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Schedule(),
    );
  }
}
