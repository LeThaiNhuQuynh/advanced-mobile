import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  ScheduleCard({super.key, required this.tutor});

  Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wed, 10 Jan 24',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 20),
          ),
          Text(
            '1 lesson',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(tutor.avatar),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tutor.name,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 24),
                          ),
                          Row(children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10, top: 8),
                              child: Image.asset(
                                'assets/images/philippines.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Text(
                              tutor.country,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                          ]),
                          TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    color: Color(0xFF0071f0),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('Direct message',
                                      style: TextStyle(
                                        color: Color(0xFF0071f0),
                                      )),
                                ],
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '18:00 - 18:30',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          child: TextButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {})),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1.0,
                    )),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.0,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Request For Lesson',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Edit Request',
                                    style: TextStyle(
                                      color: Color(0xFF0071f0),
                                      fontSize: 16,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                'Currently there are no requests for this class. Please write down any requests for the teacher.',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 4, horizontal: 16)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade200),
                  ),
                  child: Text(
                    'Go To Meeting',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}
