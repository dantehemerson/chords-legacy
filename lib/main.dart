// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_drive/app.dart';

// Extensions:
import 'package:test_drive/extensions/string_extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the game to portrait mode on mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
}
