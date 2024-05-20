import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:test_drive/bottom_navigation_view/bottom_bar_view.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/views/search_view.dart';

class App extends StatefulWidget {
  final Future<List<ChordModel>> chordsFuture;

  App({super.key}) : chordsFuture = loadChords();

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
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

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
                        chords: chords));
              case 1:
                return const Text('Collections');
              case 2:
                return const Text('Favorites');
              default:
                return const Text('Error');
            }
          }

          return MaterialApp(
              theme: ThemeData.light().copyWith(
                primaryColor: Colors.black,
                colorScheme: const ColorScheme.light().copyWith(
                    primary: Colors.black,
                    secondary: Colors.white,
                    tertiary: const Color(0xFF2465FF)),
              ),
              darkTheme: ThemeData.dark().copyWith(
                  primaryColor: Colors.white,
                  colorScheme: const ColorScheme.dark().copyWith(
                      primary: Colors.white,
                      secondary: Colors.black,
                      tertiary: const Color.fromARGB(255, 72, 127, 255))),
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
