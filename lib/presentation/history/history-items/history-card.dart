import 'package:advanced_mobile_project/common/avatar.dart';
import 'package:advanced_mobile_project/core/dtos/class-dto.dart';
import 'package:advanced_mobile_project/core/models/tutor.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  HistoryCard({super.key, required this.classDTO, required this.reloadList});

  ClassDTO classDTO;
  final void Function() reloadList;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.grey[300],
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            classDTO.date,
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
                Avatar(
                    radius: 50,
                    avatarText: classDTO.tutorName ?? "",
                    imageUrl: classDTO.tutorAvatar ?? ""),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            classDTO.tutorName ?? "Unknown",
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
                              classDTO.tutorCountry ?? "Unknown",
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
                'Lesson time: ${classDTO.time}',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: classDTO.studentRequest == null
                                ? Text(
                                    'No request for lesson',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 18),
                                  )
                                : Text(
                                    'Request for lesson\n\n${classDTO.studentRequest}',
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
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: classDTO.tutorReview == null
                                ? Text(
                                    'Tutor has not reviewed yet',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 18),
                                  )
                                : Text(
                                    'Tutor reviewed:\n\n${classDTO.studentRequest}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: classDTO.rating == null
                                ? Text(
                                    'Add a rating',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 18),
                                  )
                                : Row(
                                    children: List.generate(
                                      5,
                                      (index) => Container(
                                        margin: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          index < classDTO.rating!
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          TextButton(
                            onPressed: null,
                            child: Text(
                              'Report',
                              style: TextStyle(
                                color: Color(0xFF0071f0),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          )
        ]));
  }
}
