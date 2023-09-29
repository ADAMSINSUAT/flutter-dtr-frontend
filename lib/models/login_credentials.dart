// To parse this JSON data, do
//
//     final LoginCredentials = UserDataFromJson(jsonString);

import 'dart:convert';

List<LoginCredentials> loginCredentialsFromJson(String str) =>
    List<LoginCredentials>.from(json.decode(str).map((x) => LoginCredentials.fromJson(x)));

String loginCredentialsToJson(List<LoginCredentials> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginCredentials {
  String username;
  String password;

  LoginCredentials({
    required this.username,
    required this.password,
  });

  factory LoginCredentials.fromJson(Map<String, dynamic> json) => LoginCredentials(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}