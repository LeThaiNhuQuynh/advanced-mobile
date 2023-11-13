import 'package:advanced_mobile_project/presentation/tutor-list/tutor-list-items/multi-filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import 'tutor-list-items/date-picker.dart';
import 'tutor-list-items/time-picker.dart';

class TutorList extends StatelessWidget {
  const TutorList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        'assets/svgs/logo.svg',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: SvgPicture.asset(
                              'assets/svgs/menu.svg',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: const Text(
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
                    ),
                    SizedBox(height: 20),
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
                        SizedBox(width: 20),
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
                    SizedBox(height: 15),
                    Container(
                      child: const Text(
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
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: DatePicker(),
                      width: 180,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          child: TimePicker(displayText: "Start time"),
                          width: 170,
                        ),
                        SizedBox(width: 15),
                        Container(
                          child: TimePicker(displayText: "End time"),
                          width: 150,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MultiFilter(
                          items: ["Item 1", "Item 2", "Item 3", "Item 4"],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ],
                )),
          ]))),
    );
  }
}
