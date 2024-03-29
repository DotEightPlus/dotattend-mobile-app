import 'package:dot_attend/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ));
}

