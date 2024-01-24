import 'package:advanced_mobile_project/core/constants/api.dart';
import 'package:advanced_mobile_project/core/dtos/class-dto.dart';
import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
import 'package:advanced_mobile_project/utils/timestamp-to-datetime.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../core/constants/share-preference.dart';

class UserService {
  UserService._();

  static final UserService instance = UserService._();

  Future<Map> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.get(Uri.parse('$SERVER_HOST$USER_INFO'), headers: {
      'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
    });
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserDTO userDTO = UserDTO.fromJson(decodedResponse["user"]);
      await prefs.setString(USER_KEY, jsonEncode(userDTO.toJson()));
      return {"status": response.statusCode.toString(), "user": userDTO};
    } else if (response.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);

      return {
        "status": response.statusCode.toString(),
        "message": decodedResponse["message"],
        "user": null
      };
    } else {
      return {
        "status": response.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map> getTotalLessonHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await http.get(Uri.parse('$SERVER_HOST$TOTAL_LESSON_HOURS'), headers: {
      'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
    });
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {
        "status": response.statusCode.toString(),
        "totalLessonHours": decodedResponse["total"]
      };
    } else if (response.statusCode == 401) {
      return {
        "status": response.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    } else {
      return {
        "status": response.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map> getUpcomingLesson(int timezone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.get(Uri.parse('$SERVER_HOST$UPCOMING_LESSON'),
        headers: {'Authorization': 'Bearer ${prefs.get(TOKEN_KEY)}'});

    Map decodedResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List data = decodedResponse["data"];
      DateTime startTime = TimestampToDateTime.transfer(
          data.first["scheduleDetailInfo"]["startPeriodTimestamp"],
          timezone: timezone);
      DateTime endTime = TimestampToDateTime.transfer(
          data.first["scheduleDetailInfo"]["endPeriodTimestamp"],
          timezone: timezone);
      String meetingLink = data.first["studentMeetingLink"];
      // Define the regular expression pattern
      RegExp regex = RegExp(r"token=([^\&]+)");

      // Match the pattern in the input string
      Match? match = regex.firstMatch(meetingLink);

      // Extract the token
      String token = match?.group(1) ?? "";
      ClassDTO upcomingClassDTO = ClassDTO(
          date: DateFormat('EEE, dd MMM yy').format(startTime),
          time:
              '${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}',
          tutorId: data.first["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]
              ["id"],
          userId: data.first["userId"],
          token: token);

      return {
        "status": res.statusCode.toString(),
        "upcomingClass": upcomingClassDTO,
        "startTime": startTime
      };
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    } else {
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map> getClassList(int timezone, int currentPage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.get(
        Uri.parse(
            '$SERVER_HOST/booking/list/student?page=${currentPage}&perPage=20&inFuture=1&orderBy=meeting&sortBy=asc'),
        headers: {'Authorization': 'Bearer ${prefs.get(TOKEN_KEY)}'});

    List<ClassDTO> classList = [];

    Map decodedResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (decodedResponse["data"]['count'] == 0) {
        return {"status": res.statusCode.toString(), "classList": []};
      }

      List data = decodedResponse["data"]["rows"];

      for (var i = 0; i < data.length; i++) {
        DateTime startTime = TimestampToDateTime.transfer(
            data[i]["scheduleDetailInfo"]["startPeriodTimestamp"],
            timezone: timezone);
        DateTime endTime = TimestampToDateTime.transfer(
            data[i]["scheduleDetailInfo"]["endPeriodTimestamp"],
            timezone: timezone);
        String meetingLink = data[i]["studentMeetingLink"];
        // Define the regular expression pattern
        RegExp regex = RegExp(r"token=([^\&]+)");
        // Match the pattern in the input string
        Match? match = regex.firstMatch(meetingLink);
        // Extract the token
        String token = match?.group(1) ?? "";
        ClassDTO upcomingClassDTO = ClassDTO(
          date: DateFormat('EEE, dd MMM yy').format(startTime),
          time:
              '${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}',
          tutorId: data[i]["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]
              ["id"],
          userId: data[i]["userId"],
          token: token,
          tutorName: data[i]["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]
              ["name"],
          tutorAvatar: data[i]["scheduleDetailInfo"]["scheduleInfo"]
              ["tutorInfo"]["avatar"],
          tutorCountry: data[i]["scheduleDetailInfo"]["scheduleInfo"]
              ["tutorInfo"]["country"],
          scheduleId: data[i]["id"],
        );

        classList.add(upcomingClassDTO);
      }

      return {
        "status": res.statusCode.toString(),
        "classList": classList,
        "total": (decodedResponse["data"]['count'] / 20).ceil() //perPage=20
      };
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    } else {
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map> cancelClass(String scheduleId, int option, String note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.delete(
        Uri.parse(
          '$SERVER_HOST/booking/schedule-detail',
        ),
        headers: {
          'Authorization': 'Bearer ${prefs.get(TOKEN_KEY)}',
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "scheduleDetailId": scheduleId,
          "cancelInfo": {
            "cancelReasonId": option,
            if (note.isNotEmpty) "note": note
          }
        }));

    Map decodedResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return {
        "status": res.statusCode.toString(),
      };
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    } else {
      print(decodedResponse["message"]);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map> getHistoryList(int timezone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.get(
        Uri.parse(
            '$SERVER_HOST/booking/list/student?page=1&perPage=20&inFuture=0&orderBy=meeting&sortBy=desc'),
        headers: {'Authorization': 'Bearer ${prefs.get(TOKEN_KEY)}'});

    List<ClassDTO> classList = [];

    Map decodedResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (decodedResponse["data"]['count'] == 0) {
        return {"status": res.statusCode.toString(), "classList": []};
      }

      List data = decodedResponse["data"]["rows"];

      for (var i = 0; i < data.length; i++) {
        DateTime startTime = TimestampToDateTime.transfer(
            data[i]["scheduleDetailInfo"]["startPeriodTimestamp"],
            timezone: timezone);
        DateTime endTime = TimestampToDateTime.transfer(
            data[i]["scheduleDetailInfo"]["endPeriodTimestamp"],
            timezone: timezone);
        String meetingLink = data[i]["studentMeetingLink"];
        int rating = 0;
        if (data[i]["feedbacks"].length > 0) {
          rating = data[i]["feedbacks"][0]["rating"];
        }
        // Define the regular expression pattern
        RegExp regex = RegExp(r"token=([^\&]+)");
        // Match the pattern in the input string
        Match? match = regex.firstMatch(meetingLink);
        // Extract the token
        String token = match?.group(1) ?? "";

        ClassDTO classDTO = ClassDTO(
          date: DateFormat('EEE, dd MMM yy').format(startTime),
          time:
              '${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}',
          tutorId: data[i]["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]
              ["id"],
          userId: data[i]["userId"],
          token: token,
          tutorName: data[i]["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]
              ["name"],
          tutorAvatar: data[i]["scheduleDetailInfo"]["scheduleInfo"]
              ["tutorInfo"]["avatar"],
          tutorCountry: data[i]["scheduleDetailInfo"]["scheduleInfo"]
              ["tutorInfo"]["country"],
          scheduleId: data[i]["id"],
          tutorReview: data[i]["tutorReview"],
          studentRequest: data[i]["studentRequest"],
          rating: rating,
        );

        classList.add(classDTO);
      }

      return {
        "status": res.statusCode.toString(),
        "classList": classList,
        "total": (decodedResponse["data"]['count'] / 20).ceil()
      }; //perPage=20
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    } else {
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }
}
