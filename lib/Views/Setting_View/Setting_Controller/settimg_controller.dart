import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var notificationsEnabled = true.obs;
  var language = 'العربية'.obs;
  var fontSize = 14.0.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    // يمكنك هنا تغيير سمة التطبيق
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void changeLanguage(String lang) {
    language.value = lang;
    // هنا يمكنك تغيير لغة التطبيق
  }

  void changeFontSize(double size) {
    fontSize.value = size;
  }
}