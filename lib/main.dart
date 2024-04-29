import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_drive/components/chord_widget.dart';
import 'package:test_drive/models/chord_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<List<ChordModel>> chordsFuture;

  MyApp({Key? key})
      : chordsFuture = loadChords(),
        super(key: key);

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
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChordModel>>(
      future: chordsFuture,
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

          print("Chords are $chords");

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SimpleGridDemo(chords: chords),
          );
        }
      },
    );
    // #2465ff
  }
}

class SimpleGridDemo extends StatelessWidget {
  final List<ChordModel> chords;

  const SimpleGridDemo({super.key, required this.chords});

  @override
  Widget build(BuildContext context) {
    print("Building SimpleGridDemo");
    print(this.chords);

    return Scaffold(
      appBar: AppBar(title: Text('GridView Demo')),
      backgroundColor: Colors.white,
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          //physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 3 / 4,
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: List.generate(1, (index) {
            return ChordWidget(key: ValueKey(index));
          })),
    );
  }
}
