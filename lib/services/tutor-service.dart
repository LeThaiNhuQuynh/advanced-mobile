import 'dart:convert';

import 'package:advanced_mobile_project/core/constants/api.dart';
import 'package:advanced_mobile_project/core/constants/share-preference.dart';
import 'package:advanced_mobile_project/core/dtos/filter-item-dto.dart';
import 'package:advanced_mobile_project/core/models/general-tutor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../core/dtos/general-tutor-dto.dart';

class TutorService {
  TutorService._();
  static final TutorService instance = TutorService._();

  Future<Map> geTutorList(int perPage, int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await http.post(
      Uri.parse('$SERVER_HOST$TUTOR/search'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "filters": {
          "specialties": [],
          "date": null,
          "nationality": {},
          "tutoringTimeAvailable": [null, null]
        },
        "page": page.toString(),
        "perPage": perPage
      }),
    );

    var decodedResponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List<GeneralTutorDTO> tutors = decodedResponse["rows"]
          .cast<Map<String, dynamic>>()
          .map<GeneralTutorDTO>((tutor) => GeneralTutorDTO.fromJson(tutor))
          .toList();

      return {
        "status": res.statusCode.toString(),
        "tutors": tutors,
        "total": (decodedResponse["count"] / perPage).ceil()
      };
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"],
        "tutors": null
      };
    } else {
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map> getFilterItem() async {
    List<FilterItemDTO> specialities = [FilterItemDTO(name: "All", key: 'all')];

    var res1 = await http.get(Uri.parse('$SERVER_HOST/learn-topic'));
    if (res1.statusCode == 200) {
      List learnTopicResponse = jsonDecode(res1.body);
      specialities = [
        ...specialities,
        ...learnTopicResponse
            .map<FilterItemDTO>(
                (speciality) => FilterItemDTO.fromJson(speciality))
            .toList()
      ];
    }

    var res2 = await http.get(Uri.parse('$SERVER_HOST/test-preparation'));
    if (res2.statusCode == 200) {
      List testPreparationResponse = jsonDecode(res2.body);
      specialities = [
        ...specialities,
        ...testPreparationResponse
            .map<FilterItemDTO>(
                (speciality) => FilterItemDTO.fromJson(speciality))
            .toList()
      ];
    }

    if (res1.statusCode == 401 || res2.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(TOKEN_KEY);
      return {"status": "401"};
    }

    return {"status": "200", "specialities": specialities};
  }

  // Future<Map> getFeedbacks(String id, int perPage, int page) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   var res = await http.get(
  //       Uri.parse('$SERVER_HOST/feedback/v2/$id?page=$page&perPage=$perPage'),
  //       headers: {
  //         'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
  //       });
  //
  //   var decodedResponse = jsonDecode(res.body);
  //
  //   if (res.statusCode == 200) {
  //     List<FeedbackDTO> feedbacks = decodedResponse["data"]["rows"]
  //         .cast<Map<String, dynamic>>()
  //         .map<FeedbackDTO>((feedback) => FeedbackDTO.fromJson(feedback))
  //         .toList();
  //
  //     return {
  //       "status": res.statusCode.toString(),
  //       "feedbacks": feedbacks,
  //       "total": (decodedResponse["data"]["count"] / perPage).ceil()
  //     };
  //   } else if (res.statusCode == 401) {
  //     await prefs.remove(TOKEN_KEY);
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"],
  //       "feedbacks": null
  //     };
  //   } else {
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"]
  //     };
  //   }
  // }
  //
  // Future<Map> favoriteTutor(String id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   var res =
  //       await http.post(Uri.parse('$SERVER_HOST/user/manageFavoriteTutor'),
  //           headers: {
  //             "Authorization": "Bearer ${prefs.getString(TOKEN_KEY)}",
  //             "Content-Type": "application/json",
  //           },
  //           body: jsonEncode({"tutorId": id}));
  //
  //   Map decodedResponse = jsonDecode(res.body);
  //   if (res.statusCode == 200) {
  //     return {"status": res.statusCode.toString(), "data": decodedResponse};
  //   } else if (res.statusCode == 401) {
  //     await prefs.remove(TOKEN_KEY);
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"]
  //     };
  //   } else {
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"]
  //     };
  //   }
  // }
  //
  // Future<Map> reportTutor(String id, String content) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var res = await http.post(Uri.parse('$SERVER_HOST/report'),
  //       headers: {
  //         "Authorization": "Bearer ${prefs.getString(TOKEN_KEY)}",
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({"tutorId": id, "content": content}));
  //   Map decodedResponse = jsonDecode(res.body);
  //   if (res.statusCode == 200) {
  //     return {"status": res.statusCode.toString(), "data": decodedResponse};
  //   } else if (res.statusCode == 401) {
  //     await prefs.remove(TOKEN_KEY);
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"]
  //     };
  //   } else {
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"]
  //     };
  //   }
  // }
  //
  // Future<Map> getScheduleByTutor(
  //     String userId, String tutorId, int page, int timezone) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   var res = await http.get(
  //       Uri.parse('$SERVER_HOST/schedule?page=$page&tutorId=$tutorId'),
  //       headers: {
  //         'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
  //       });
  //
  //   var decodedResponse = jsonDecode(res.body);
  //
  //   if (res.statusCode == 200) {
  //     List<ScheduleDTO> schedules =
  //         decodedResponse['scheduleOfTutor'].map<ScheduleDTO>((schedule) {
  //       DateTime startTime = Timestamp.timestamp2DateTime(
  //           schedule['startTimestamp'],
  //           timezone: timezone);
  //       DateTime endTime = Timestamp.timestamp2DateTime(
  //           schedule['endTimestamp'],
  //           timezone: timezone);
  //
  //       bool? isBooker = null;
  //
  //       if (schedule['isBooked']) {
  //         String userBookingId =
  //             schedule['scheduleDetails'].first['bookingInfo'].last['userId'];
  //
  //         isBooker = userBookingId == userId;
  //       }
  //
  //       return ScheduleDTO(
  //         id: schedule['scheduleDetails'].first['id'],
  //         date: DateTime(startTime.year, startTime.month, startTime.day),
  //         startTime: startTime,
  //         endTime: endTime,
  //         isBooked: schedule['isBooked'],
  //         isBooker: isBooker,
  //       );
  //     }).toList();
  //
  //     return {
  //       "status": res.statusCode.toString(),
  //       "schedules": schedules,
  //     };
  //   } else if (res.statusCode == 401) {
  //     await prefs.remove(TOKEN_KEY);
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"],
  //       "feedbacks": null
  //     };
  //   } else {
  //     return {
  //       "status": res.statusCode.toString(),
  //       "message": decodedResponse["message"]
  //     };
  //   }
  // }
}
