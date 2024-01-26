import 'package:advanced_mobile_project/core/dtos/class-dto.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor-list-items/countdown.dart';
import 'package:advanced_mobile_project/presentation/video-call/go-meeting.dart';
import 'package:flutter/material.dart';

class MyBanner extends StatefulWidget {
  MyBanner({
    super.key,
    required this.totalLessonHours,
    required this.upcomingClassDTO,
    required this.countdownDuration,
    required this.startTime,
  });

  int totalLessonHours;
  ClassDTO? upcomingClassDTO;
  Duration? countdownDuration;
  DateTime startTime;

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  String handleTotalLessonHours(int inMinutes) {
    int hours = inMinutes ~/ 60;
    int minutes = inMinutes % 60;
    String hourString = "";
    String minuteString = "";

    if (hours == 0) {
      hourString = "";
    } else if (hours == 1) {
      hourString = "1 hour";
    } else {
      hourString = "$hours hours";
    }

    if (minutes == 0) {
      minuteString = "0 minute";
    } else if (minutes == 1) {
      minuteString = "1 minute";
    } else {
      minuteString = "$minutes minutes";
    }

    return "$hourString $minuteString";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              'Upcoming lesson',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          widget.upcomingClassDTO == null
              ? Text('You have no upcoming lesson')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.upcomingClassDTO!.date,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.upcomingClassDTO == null
                              ? ""
                              : widget.upcomingClassDTO!.time,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        if (widget.countdownDuration != null)
                          Countdown(
                            duration: widget.countdownDuration!,
                          ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(
                          color: Colors
                              .white, // Set your desired border color here
                          width: 2.0, // Set the border width
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoinMeetingScreen(
                                      userId: widget.upcomingClassDTO!.userId,
                                      tutorId: widget.upcomingClassDTO!.tutorId,
                                      token: widget.upcomingClassDTO!.token,
                                      startTime: widget.startTime!)));
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.smart_display_outlined,
                            color: Color(0xFF0071f0),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Enter lesson room',
                            style: TextStyle(
                              color: Color(0xFF0071f0),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Total lesson time is ${handleTotalLessonHours(widget.totalLessonHours)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
