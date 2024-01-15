import 'dart:convert';
import 'dart:html';
import 'package:advanced_mobile_project/core/dtos/login-dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../core/constants/api.dart';
import '../core/constants/share-preference.dart';

class AuthenticationApi {
  AuthenticationApi._();
  static final AuthenticationApi instance = AuthenticationApi._();

  Future<Map<String, String>> login(LoginDTO loginDTO) async {
    var response = await http.post(
      Uri.parse("$SERVER_HOST$LOGIN"),
      headers: {
        "Content-Type": "application/json",
      },
      body:
          jsonEncode({"email": loginDTO.email, "password": loginDTO.password}),
    );

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    Map<String, String> result = {
      "status": response.statusCode.toString(),
    };
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          TOKEN_KEY, decodedResponse["tokens"]["access"]["token"]);
      result["message"] = "Login successfully";
    } else {
      result["message"] = decodedResponse["message"];
    }
    return result;
  }

  Future<Map> register(LoginDTO loginDTO) async {
    var response = await http.post(
      Uri.parse("$SERVER_HOST$REGISTER"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": loginDTO.email,
        "password": loginDTO.password,
        "source": null
      }),
    );
    Map decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          TOKEN_KEY, decodedResponse["tokens"]["access"]["token"]);
      return {
        "status": response.statusCode.toString(),
        "message": "Register successfully"
      };
    } else {
      return {
        "status": response.statusCode.toString(),
        "message": decodedResponse["message"]
      };
    }
  }

  Future<Map<String, String>> forgotPassword(String email) async {
    var response = await http.post(
      Uri.parse("$SERVER_HOST$FORGOT"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email}),
    );

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    Map<String, String> result = {
      "status": response.statusCode.toString(),
    };
    if (response.statusCode == 200) {
      result["message"] = "Send reset password successfully";
    } else {
      result["message"] = decodedResponse["message"];
    }
    return result;
  }
}
