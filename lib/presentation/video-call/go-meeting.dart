import 'dart:async';

import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor-list-items/countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JoinMeetingScreen extends StatefulWidget {
  JoinMeetingScreen(
      {super.key,
      required this.userId,
      required this.tutorId,
      required this.token,
      required this.startTime});

  DateTime startTime;
  String userId;
  String tutorId;
  String token;

  @override
  _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  Duration? _countdownDuration;

  @override
  void initState() {
    super.initState();
    // startTime = DateTime.now().add(Duration(minutes: 10));
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {});
    // });
    setState(() {
      _countdownDuration = widget.startTime.difference(DateTime.now());
    });
  }

  static _joinMeeting(String userId, String tutorId, String token) async {
    var jitsiMeet = JitsiMeet();
    var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.lettutor.com",
        room: "$userId-$tutorId",
        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
          "subject": "Jitsi with Flutter",
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          "tileView.enabled": true,
        },
        token: token);
    jitsiMeet.join(options, JitsiMeetEventListener(
      readyToClose: ({message}) {
        print("readyToClose");
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();

    return MaterialApp(
      home: Scaffold(
        key: _key,
        appBar: Header(scaffoldKey: _key),
        endDrawer: Menu(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_countdownDuration != null)
                Countdown(
                  duration: _countdownDuration!,
                ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF0071f0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                onPressed: () {
                  _joinMeeting(widget.userId, widget.tutorId, widget.token);
                },
                child: Text(
                  "Click here to prepare for the meeting",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
