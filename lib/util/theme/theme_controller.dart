import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode =
      (Get.find<SharedPreferences>().getBool('dark') ?? false)
          ?ThemeMode.dark.obs
          : ThemeMode.light.obs;

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
    Get.changeThemeMode(themeMode.value);
  }
}
