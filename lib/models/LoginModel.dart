// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.message,
    this.jwt,
    this.id,
  });

  String? message;
  String? jwt;
  String? id;
  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        message: json["message"] == null ? null : json["message"],
        jwt: json["jwt"] == null ? null : json["jwt"],
        id: json["client_id"] == null ? null : json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "jwt": jwt == null ? null : jwt,
        "client_id": id == null ? null : id,
      };
}
