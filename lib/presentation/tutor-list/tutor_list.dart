import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor-list-items/tutor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../core/models/tutor.dart';
import 'tutor-list-items/date_picker.dart';
import 'tutor-list-items/filter_item.dart';
import 'tutor-list-items/time_picker.dart';

class TutorList extends StatelessWidget {
  TutorList({super.key});

  List<String> filterItems = [
    'All',
    'English for kids',
    'English for business',
    'Conversational',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC',
    'SAT'
  ];

  List<Tutor> tutorList = [
    Tutor(
        avatar: 'assets/images/avatar1.jpeg',
        name: "Keegen",
        country: "Philippines",
        feedback: 3,
        introduction:
            "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
        liked: true,
        subjects: [
          'English for kids',
          'English for business',
          'Conversational',
          'STARTERS'
        ]),
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //list of filter items
    List<Widget> filterWidgets = filterItems.map((String item) {
      return FilterItem(content: item);
    }).toList();

    //list of tutor cards
    List<Widget> tutorWidgets = tutorList.map((Tutor tutor) {
      return TutorCard(tutor: tutor);
    }).toList();

    GlobalKey<ScaffoldState> _key = GlobalKey();

    return MaterialApp(
      home: Scaffold(
          key: _key,
          appBar: Header(scaffoldKey: _key),
          endDrawer: Menu(),
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(12, 61, 223, 1),
                    Color.fromRGBO(5, 23, 157, 1),
                  ],
                  stops: [0.0, 1.0],
                  transform: GradientRotation(144 * 3.14159 / 180),
                ),
              ),
              child: const Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'You have no upcoming lesson',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Total lesson time is 515 hours 50 minutes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
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
                            color: Color(
                                0xFF0071f0), // Set your desired border color here
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
                    const Icon(
                      Icons.calendar_today,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/tutor.svg',
                      color: Color(0xFF0071f0),
                      height: 20,
                      width: 20,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: tutorWidgets,
                    ),
                  ],
                )),
          ]))),
    );
  }
}
