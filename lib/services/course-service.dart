import 'dart:convert';

import 'package:advanced_mobile_project/core/constants/api.dart';
import 'package:advanced_mobile_project/core/constants/share-preference.dart';
import 'package:advanced_mobile_project/core/dtos/course-dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CourseService {
  CourseService._();

  static CourseService instance = CourseService._();

  Future<Map> getListCourses(page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(TOKEN_KEY)!;

    var res = await http
        .get(Uri.parse('$SERVER_HOST/course?page=$page&size=100'), headers: {
      "Authorization": "Bearer $token",
    });
    Map decodedResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      Set<String> categories = Set();
      List<CourseDTO> courses =
          decodedResponse["data"]["rows"].map<CourseDTO>((course) {
        CourseDTO courseDTO = CourseDTO.fromJson(course);
        categories.add(courseDTO.category);
        return courseDTO;
      }).toList();
      Map<String, List<CourseDTO>> coursesByCategory = Map();
      categories.forEach((category) {
        coursesByCategory[category] =
            courses.where((course) => course.category == category).toList();
      });
      return {
        "status": res.statusCode.toString(),
        "coursesByCategory": coursesByCategory,
        "total": (decodedResponse["data"]["count"] / 100).ceil()
      };
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"],
      };
    } else {
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"],
      };
    }
  }

  Future<Map> findCourses(String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(TOKEN_KEY)!;

    var res = await http.get(
        Uri.parse('$SERVER_HOST/course?page=1&size=100&q=${content}'),
        headers: {
          "Authorization": "Bearer $token",
        });
    Map decodedResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      Set<String> categories = Set();
      List<CourseDTO> courses =
          decodedResponse["data"]["rows"].map<CourseDTO>((course) {
        CourseDTO courseDTO = CourseDTO.fromJson(course);
        categories.add(courseDTO.category);
        return courseDTO;
      }).toList();
      Map<String, List<CourseDTO>> coursesByCategory = Map();
      categories.forEach((category) {
        coursesByCategory[category] =
            courses.where((course) => course.category == category).toList();
      });
      return {
        "status": res.statusCode.toString(),
        "coursesByCategory": coursesByCategory,
        "total": (decodedResponse["data"]["count"] / 100).ceil()
      };
    } else if (res.statusCode == 401) {
      await prefs.remove(TOKEN_KEY);
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"],
      };
    } else {
      return {
        "status": res.statusCode.toString(),
        "message": decodedResponse["message"],
      };
    }
  }
}
