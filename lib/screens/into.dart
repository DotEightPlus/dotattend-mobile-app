import 'package:dot_attend/constants/asset_path.dart';
import 'package:dot_attend/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroScreen extends StatelessWidget {
  final box = GetStorage();
  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF121A8A),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset(a),
      body: const Text(
        'Hassle-free  attendance signing or marking  of  all classes',
      ),
      title: const Text(
        'DotAttend',
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      bodyTextStyle: const TextStyle(color: Colors.white),
      mainImage: Image.asset(
        a,
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: const Color(0xFF121A8A),
      iconImageAssetPath: b,
      body: const Text(
        'We  work  for  the  comfort ,  enjoy  Attendance Signing',
      ),
      title: const Text('DotAttend'),
      mainImage: Image.asset(
        b,
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      bodyTextStyle: const TextStyle(color: Colors.white),
    ),
    PageViewModel(
      // pageBackground: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       stops: [0.0, 1.0],
      //       begin: FractionalOffset.topCenter,
      //       end: FractionalOffset.bottomCenter,
      //       tileMode: TileMode.repeated,
      //       colors: [
      //         Colors.orange,
              
      //       ],
      //     ),
      //   ),
      // ),
      pageColor: const Color(0xFF121A8A),
      iconImageAssetPath: c,
      body: const Text(
        'Easy  Attendance  Signing  from  your  mobile device either online or offline',
      ),
      title: const Text('DotAttend'),
      mainImage: Image.asset(
        c,
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      bodyTextStyle: const TextStyle(color: Colors.white),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          // Use Navigator.pushReplacement if you want to dispose the latest route
          // so the user will not be able to slide back to the Intro Views.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        },
        pageButtonTextStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
