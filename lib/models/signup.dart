// To parse this JSON data, do
//
//     final signup = signupFromJson(jsonString);

import 'dart:convert';

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
    Signup({
        this.fullname,
        this.matricno,
        this.dept,
        this.level,
        this.faculty,
        this.pin,
        this.password,
    });

    String fullname;
    String matricno;
    String dept;
    String level;
    String faculty;
    String pin;
    String password;

    factory Signup.fromJson(Map<String, dynamic> json) => Signup(
        fullname: json["fullname"],
        matricno: json["matricno"],
        dept: json["dept"],
        level: json["level"],
        faculty: json["faculty"],
        pin: json["pin"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "matricno": matricno,
        "dept": dept,
        "level": level,
        "faculty": faculty,
        "pin": pin,
        "password": password,
    };
}
