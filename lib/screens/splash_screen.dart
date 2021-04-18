import 'package:dot_attend/resources/auth_methods.dart';
import 'package:dot_attend/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Welcome/components/background.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashFunction();
    super.initState();
  }

  // ignore: unused_field
  AuthMethods _authMethods = AuthMethods();

  /// The dummy time function for splash screen
  splashFunction() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            Column(
              children: [
                Center(
                    child: Lottie.asset(
                  'assets/character.json',
                  repeat: true,
                  // height: 300,
                  // width: 300
                )),
                Text("Welcome to Dot Attend",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 40, top: 70),
                child: Row(
                  children: [
                    Text(
                      "Loading",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    CircularProgressIndicator(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
