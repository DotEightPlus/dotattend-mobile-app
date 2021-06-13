import 'package:dot_attend/models/user.dart';
import 'package:dot_attend/screens/Login/login_screen.dart';
import 'package:dot_attend/services/remote_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RequestController extends GetxController {
  static RequestController instance = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController matricNoController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<UserData> userData = UserData().obs;
  final box = GetStorage();

  signup() async {
    int statusCode = await RemoteServices.signup(
      fullname: nameController.text.trim(),
      dept: deptController.text.trim(),
      matricNo: matricNoController.text.trim(),
      faculty: facultyController.text.trim(),
      level: levelController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (statusCode == 200) {
      clearControllers();
      Get.snackbar(
        "Success",
        "Sign Up Successful. Please proceed to sign in",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(LoginScreen());
    } else {
      clearControllers();
      Get.snackbar(
        "Error!",
        "Sign Up Error. Please check your connection",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signIn() async {
    try {
      UserData data = await RemoteServices.signin(
        matricNo: matricNoController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (data != null) {
        box.write("UserData", data);
        userData.value = data;
      }
    } finally {
      // isLoading(false);
    }
  }

  clearControllers() {
    nameController.clear();
    matricNoController.clear();
    deptController.clear();
    levelController.clear();
    facultyController.clear();
    passwordController.clear();
  }
}
