// To parse this JSON data, do
//
//     final UserData = UserDataFromJson(jsonString);

import 'dart:convert';

List<UserData> userDataFromJson(String str) => List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
    int empId;
    String firstName;
    String lastName;
    String mi;
    DateTime dateOfBirth;
    String email;
    String department;
    String role;
    String status;
    String username;

    UserData({
        required this.empId,
        required this.firstName,
        required this.lastName,
        required this.mi,
        required this.dateOfBirth,
        required this.email,
        required this.department,
        required this.role,
        required this.status,
        required this.username,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        empId: json["empId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mi: json["mi"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        email: json["email"],
        department: json["department"],
        role: json["role"],
        status: json["status"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "empId": empId,
        "firstName": firstName,
        "lastName": lastName,
        "mi": mi,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "email": email,
        "department": department,
        "role": role,
        "status": status,
        "username": username,
    };
}