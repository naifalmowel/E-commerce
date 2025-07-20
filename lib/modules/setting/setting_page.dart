import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/util/theme/theme_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

bool isDark = false;
final themeController = Get.find<ThemeController>();

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    isDark = Get.find<SharedPreferences>().getBool('dark') ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SettingsList(
        contentPadding: const EdgeInsets.all(8),
        lightTheme: SettingsThemeData(
            settingsListBackground: Colors.white,
            settingsSectionBackground: Colors.black54.withOpacity(0.1)),
        darkTheme: const SettingsThemeData(
            settingsSectionBackground: Colors.white,
            settingsListBackground: Colors.transparent),
        sections: [
          SettingsSection(
            title: Text(
              'Theme',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            tiles: [
              SettingsTile.switchTile(
                activeSwitchColor: Colors.blueAccent,
                initialValue: isDark,
                onToggle: (bool value) {
                  isDark = value;
                  Get.find<SharedPreferences>().remove('dark');
                  Get.find<SharedPreferences>().setBool('dark', value);
                  themeController.toggleTheme();
                  setState(() {});
                },
                leading: const Icon(
                  Icons.dark_mode,
                  color: Colors.black,
                ),
                title: const Text(
                  'Dark Theme',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
