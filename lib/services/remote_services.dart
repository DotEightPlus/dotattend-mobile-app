import 'package:dot_attend/models/signup.dart';
import 'package:dot_attend/models/user.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<int> signup(
      {String fullname,
      String matricNo,
      String dept,
      String level,
      String faculty,
      String password}) async {
    var url = Uri.parse('http://127.0.0.1:8080/register');
    var response = await http.post(url, body: {
      'fullname': fullname,
      'matricNo': matricNo,
      'dept': dept,
      'level': level,
      'faculty': faculty,
      'password': password,
    });
    return response.statusCode;
    // var response = await client.get(Uri.parse(
    //     'https://127.0.0.1:8080 /register'));
    // if (response.statusCode == 200) {
    //   var jsonString = response.body;
    //   return signupFromJson(jsonString);
    // } else {
    //   //show error message
    //   return null;
    // }
  }

  static Future<UserData> signin({String matricNo, String password}) async {
    var url = Uri.parse('http://127.0.0.1:8080/signin');

    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return userDataFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
