import 'package:flutter/material.dart';
import 'colors.dart';
class MyTheme {
  static ThemeData Light = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: const ColorScheme(
      primary: blackColors,
      brightness: Brightness.light,
      onPrimary: blackColors,
      secondary: goldcolors,
      onSecondary: goldcolors,
      error: redColor,
      onError: redColor,
      background: blackColor,
      onBackground: blackColor,
      surface: grayColor,
      onSurface: grayColor,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: goldcolors, fontSize: 22, fontWeight: FontWeight.normal),
      headline2: TextStyle(
          color: blublackColor, fontSize: 22, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          color: grayColor, fontSize: 13, fontWeight: FontWeight.normal),
      headline4: TextStyle(
          color: blublackColor, fontSize: 14, fontWeight: FontWeight.w500),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: blackColors,
      showUnselectedLabels: true,
      selectedItemColor: goldcolors,
    ),
  );
}
