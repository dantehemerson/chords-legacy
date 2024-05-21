import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeMode getThemeModeFromString(String? themeMode) {
    switch (themeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
