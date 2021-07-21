import 'dart:async';

import 'package:dot_attend/screens/admin/admin.dart';
import 'package:dot_attend/screens/into.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  navigate() {
    bool newInstall =
        box.read("newInstall") == null || box.read("newInstall") == true
            ? true
            : false;

    if (newInstall) {
      Get.off(IntroScreen());
    } else {
      Get.off(Admin());
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      navigate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
        child: Text("DotAttend", style: TextStyle(
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ))
      )
    );
  }
}
