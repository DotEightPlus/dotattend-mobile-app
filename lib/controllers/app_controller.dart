import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController matricController = TextEditingController();
  RxBool scanning = false.obs;
  RxBool buttonClicked = false.obs;
  RxList dataList = [].obs;
}
