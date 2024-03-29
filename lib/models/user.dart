// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        this.role,
        this.token,
        this.fullname,
        this.matricno,
        this.dept,
        this.level,
        this.faculty,
    });

    String role;
    String token;
    String fullname;
    String matricno;
    String dept;
    String level;
    String faculty;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        role: json["role"],
        token: json["token"],
        fullname: json["fullname"],
        matricno: json["matricno"],
        dept: json["dept"],
        level: json["level"],
        faculty: json["faculty"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "token": token,
        "fullname": fullname,
        "matricno": matricno,
        "dept": dept,
        "level": level,
        "faculty": faculty,
    };
}
