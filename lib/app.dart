// ignore_for_file: no_logic_in_create_state

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/bottom_navigation_view/bottom_bar_view.dart';
import 'package:test_drive/constants/system_preference_key.dart';
import 'package:test_drive/generated/l10n.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/themes/app_theme.dart';
import 'package:test_drive/views/search_view.dart';

class App extends StatefulWidget {
  final Future<List<ChordModel>> chordsFuture;
  final ThemeMode initialThemeMode;
  final Locale locale;

  App({super.key, required this.initialThemeMode, required this.locale})
      : chordsFuture = loadChords();

  static Future<List<ChordModel>> loadChords() async {
    try {
      String jsonString = await rootBundle.loadString('lib/data/chords.json');
      List<dynamic> jsonList = jsonDecode(jsonString);

      List<ChordModel> chords =
          jsonList.map((json) => ChordModel.fromJson(json)).toList();

      return chords;
    } catch (error) {
      print('Error loading chords: $error');
      return [];
    }
  }

  @override
  State<App> createState() =>
      AppState(themeMode: initialThemeMode, locale: locale);
}

class AppState extends State<App> {
  int selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  ThemeMode themeMode;
  Locale locale;

  AppState({required this.themeMode, required this.locale});

  _setThemeMode(ThemeMode newThemeMode) async {
    setState(() {
      themeMode = newThemeMode;
    });
    (await SharedPreferences.getInstance())
        .setString(SystemPreferenceKey.themeMode, newThemeMode.name.toString());
  }

  _setLocale(Locale newLocale) async {
    setState(() {
      locale = newLocale;
    });

    (await SharedPreferences.getInstance())
        .setString(SystemPreferenceKey.locale, newLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChordModel>>(
      future: widget.chordsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error loading chords: ${snapshot.error}'),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          List<ChordModel> chords = snapshot.data!;

          Widget getBody() {
            switch (selectedIndex) {
              case 0:
                return KeyboardVisibilityProvider(
                    child: SearchView(
                        key: const PageStorageKey('search_view'),
                        chords: chords,
                        themeMode: themeMode,
                        setLocale: _setLocale,
                        setThemeMode: _setThemeMode));
              case 1:
                return const Text('Collections');
              case 2:
                return const Text('Favorites');
              default:
                return const Text('Error');
            }
          }

          return MaterialApp(
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: locale,
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: PageStorage(bucket: _bucket, child: getBody()),
                bottomNavigationBar: BottomBar(
                    currentIndex: selectedIndex,
                    onTap: (int index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }),
              ));
        }
      },
    );
    //
  }
}
