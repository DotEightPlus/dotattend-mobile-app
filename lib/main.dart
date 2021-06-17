import 'package:dotattend/Constants/color_constants.dart';
import 'package:dotattend/Screens/AssessCodePage.dart';
import 'package:dotattend/Screens/AttendancePage.dart';
import 'package:dotattend/Screens/IntroScreen.dart';
import 'package:dotattend/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: status_bar_color));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splashscreen",
      routes: {
        "/intro":(context)=>IntroScreen(),
        "/splashscreen":(context)=>SplashScreen(),
        "/accesscode":(context)=>AccessCodePage(),
        "/attendancepage":(context)=>AttendancePage()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
