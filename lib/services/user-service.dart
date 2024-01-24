import 'package:advanced_mobile_project/core/constants/api.dart';
import 'package:advanced_mobile_project/core/dtos/user-dto.dart';
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
}
