import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDailog {

  //info
  static void info(String msg) {
    Get.snackbar("info",msg,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    );
  }

  //success
  static void success(String msg) {
    Get.snackbar("Success",msg,
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //error
  static void error(String msg) {
    Get.snackbar("error",msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }


}