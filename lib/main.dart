// ignore_for_file: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/app.dart';
import 'package:test_drive/constants/system_preference_key.dart';
import 'package:test_drive/utils/locale_utils.dart';
import 'package:test_drive/utils/theme_utils.dart';
import 'package:test_drive/extensions/string_extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeMode initialThemeMode = ThemeUtils.getThemeModeFromString(
      (await SharedPreferences.getInstance())
          .getString(SystemPreferenceKey.themeMode));

  final localePreference = (await SharedPreferences.getInstance())
      .getString(SystemPreferenceKey.locale);

  final Locale systemLocale =
      LocaleUtils.toLocale(localePreference ?? Platform.localeName) ??
          const Locale('en');

  // Lock the game to portrait mode on mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App(
    initialThemeMode: initialThemeMode,
    locale: systemLocale,
  ));
}
