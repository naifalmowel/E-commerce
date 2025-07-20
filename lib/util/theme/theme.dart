import 'package:flutter/material.dart';

import '../colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold),
      displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.white)
  ),
  dialogBackgroundColor: Colors.white,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: secondaryColor),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white38),
);
ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: secondaryColor,
  canvasColor: Colors.transparent,
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.black)
  ),
  scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
  dialogBackgroundColor: Colors.white,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: secondaryColor),
);
