import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.black,
        secondary: Colors.white,
        tertiary: const Color(0xFF2465FF)),
  );

  static ThemeData dark = ThemeData.dark().copyWith(
      primaryColor: Colors.white,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.white,
          secondary: Colors.black,
          tertiary: const Color.fromARGB(255, 72, 127, 255)));
}
