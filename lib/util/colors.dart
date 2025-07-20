import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/login/controller/login_controller.dart';
var loginController = Get.find<LoginController>();

Color primaryColor = loginController.darkTheme.value ? Colors.black :  Colors.white;
Color secondaryColor = loginController.darkTheme.value ? Colors.blue:Colors.blueAccent;
Color errorColor =  const Color(0x00c71b27).withOpacity(1);
Color textColor = loginController.darkTheme.value ? Colors.white :const Color(0x00000000).withOpacity(1);
Color backgroundColorDropDown = const Color(0x00FFD9D9);
Color colorSnakeBarSuccess = const Color(0x0000b078).withOpacity(1);
Color colorSnakeBarError = const Color(0x00c71b27).withOpacity(0.9);
LinearGradient backgroundGradient = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.8),
    Colors.white.withOpacity(0.1),
    primaryColor.withOpacity(0.1),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0.0, 0.0, 0.9],
);
