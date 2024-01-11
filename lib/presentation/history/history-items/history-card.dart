import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  HistoryCard({super.key, required this.tutor});

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
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Lesson time: 19:00 - 20:20',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 24),
              )),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Request for lesson',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                      )
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: tutor.feedback > 0
                            ? Row(
                                children: List.generate(
                                  5,
                                  (index) => Container(
                                    margin: EdgeInsets.only(right: 4),
                                    child: Icon(
                                      index < tutor.feedback
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                'Request for lesson',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                      )
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: null,
                              child: Text(
                                'Add a rating',
                                style: TextStyle(
                                  color: Color(0xFF0071f0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                'Repor',
                                style: TextStyle(
                                  color: Color(0xFF0071f0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
