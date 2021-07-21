import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dot_attend/constants/asset_path.dart';
import 'package:dot_attend/controllers/app_controller.dart';
import 'package:dot_attend/screens/admin/admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatelessWidget {
  final AppController _appController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final box = GetStorage();
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  Widget field({String hintText, TextEditingController controller}) =>
      TextFormField(
        controller: controller,
        validator: (value) {
          // if (hintText == "Enter Matric No ***/****/****") {
          //   print('here');
          //   List check1 = value.split("/"); // mte/2018/1164
          //   print("check 1 mte ${check1[0]}");
          //   print(check1);
          //   //String check2 = check1[1].split("/"); // 2018/1164
          //   print("check 2 2018 ${check1[1]}");
          //   print("check 2 1164 ${check1[2]}");
          //   //2018[0]
          //   //1164[1]
          //   bool dept =
          //       isNumericUsingRegularExpression(check1[0]); //must be false
          //   bool year =
          //       isNumericUsingRegularExpression(check1[1]); // must be true
          //   bool matric =
          //       isNumericUsingRegularExpression(check1[2]); //must be true
          //   if (check1[0].length == 3 &&
          //       dept == false &&
          //       check1[1].length == 4 &&
          //       year == true &&
          //       check1[2].length == 4 &&
          //       matric == true &&
          //       value.length == 13) {
          //     print("pass");
          //     return null;
          //   } else {
          //     print("invalid");
          //     return "Field Cannot be empty or use a valid format of matric number ***/****/****";
          //   }
          // } else {
            return value.isEmpty ? "Field Cannot be empty " : null;
         // }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(75),
            borderSide: BorderSide(color: Colors.blue[900]),
          ),
          hintText: hintText,
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.blue[900]),
        ),
      );

  Widget button({Function onTap}) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(23),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(39),
              color: Colors.blue[900],
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(4, 8),
                  color: Colors.grey[200],
                ),
              ]),
          child: Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );

  Widget loading() => Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(39),
          color: Colors.blue[900],
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(4, 8),
              color: Colors.grey[200],
            ),
          ]),
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '...',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
          totalRepeatCount: 20,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ));
  validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  validateAndSubmit() {
    if (validateAndSave()) {
      _appController.buttonClicked.value = true;
      box.write("newInstall", false);
      box.write("name", _appController.nameController.text.trim());
      box.write("matric", _appController.matricController.text.trim());
      Timer(Duration(seconds: 3), () {
         _appController.buttonClicked.value = false;
        Get.offAll(Admin());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.10),
              Image.asset(login),
              SizedBox(height: size.height * 0.12),
              field(
                  hintText: "Enter Your Full Name",
                  controller: _appController.nameController),
              SizedBox(height: size.height * 0.05),
              field(
                  hintText: "Enter Matric No ***/****/****",
                  controller: _appController.matricController),
              SizedBox(height: size.height * 0.05),
              Obx(() => _appController.buttonClicked.value == true
                  ? loading()
                  : button(onTap: validateAndSubmit)),
            ],
          ),
        ),
      ),
    ));
  }
}
