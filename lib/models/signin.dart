// To parse this JSON data, do
//
//     final signup = signupFromJson(jsonString);

import 'dart:convert';

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
    Signup({
        this.matricno,
        this.password,
    });

    String matricno;
    String password;

    factory Signup.fromJson(Map<String, dynamic> json) => Signup(
        matricno: json["matricno"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "matricno": matricno,
        "password": password,
    };
}
