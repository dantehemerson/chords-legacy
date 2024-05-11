import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_drive/bottom_navigation_view/bottom_bar_view.dart';
import 'package:test_drive/components/chords_grid.dart';
import 'package:test_drive/models/chord_model.dart';

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
                return ChordsGrid(chords: chords);
              case 1:
                return const Text('Collections');
              case 2:
                return const Text('Favorites');
              default:
                return const Text('Error');
            }
          }

          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0x002465ff)),
              ),
              home: Scaffold(
                body: getBody(),
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
