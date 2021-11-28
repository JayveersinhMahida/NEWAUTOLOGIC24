import 'dart:convert';

import 'package:autologic/models/LoginModel.dart';
import 'package:autologic/models/Vmodel.dart';
import 'package:autologic/models/brandmodel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static late final String jwt;

  static Future getUser(String? email, String? password) async {
    final uri = Uri.parse("http://autologic24.com/api/login.php");
    final data = {
      "email": email,
      "password": password,
    };
    try {
      http.Response user = await http.post(
        uri,
        body: json.encode(data),
      );

      print(user.statusCode);
      final loginData = loginDataFromJson(user.body);
      // print(user.body);
      return loginData;
    } catch (e) {
      print(e);
    }
  }

  // static Future createUser(
  //     {String? name, String? mobile, String? email, String? password}) async {
  //   final uri = Uri.parse("http://autologic24.com/api/create_user.php");
  //   final data = {
  //     "name": name,
  //     "mobile_number": mobile,
  //     "email": email,
  //     "password": password,
  //   };
  //   try {
  //     http.Response user = await http.post(
  //       uri,
  //       body: json.encode(data),
  //     );
  //     print(user.statusCode);
  //     return user.body;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  static Future getBrand() async {
    final uri = Uri.parse("http://autologic24.com/api/vehicle_brand/read.php");
    try {
      http.Response data = await http.get(uri);
      print(data.body);
      final brandData = brandDataFromJson(data.body);
      return brandData;
    } catch (e) {
      throw e;
    }
  }

  static Future getModel(String id) async {
    final uri = Uri.parse(
        "http://autologic24.com/api/vehicle_model/read_one.php?vehicle_brand_id=$id");
    try {
      http.Response data = await http.get(uri);
      print(data.body);
      final modelData = modelDataFromJson(data.body);
      return modelData;
    } catch (e) {
      throw e;
    }
  }
}
