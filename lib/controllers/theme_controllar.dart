import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/helper/pref.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = pref.isDarkMode;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );

    pref.isDarkMode = isDarkMode.value;
  }
}