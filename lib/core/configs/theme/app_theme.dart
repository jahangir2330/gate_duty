import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xff3461FD);
  static const Color accentColor = Color(0xFFFF6584); // Pink

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffF5F9FE),
        hintStyle: const TextStyle(
          color: Color(0xff7C8BA0),
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            elevation: 0,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)))),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black87,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffF5F9FE),
        hintStyle: const TextStyle(
          color: Color(0xff7C8BA0),
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            elevation: 0,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)))),
  );
}
