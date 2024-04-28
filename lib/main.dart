import 'package:flutter/material.dart';
import 'package:test_drive/components/chord.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SimpleGridDemo(),
    );
    // #2465ff
  }
}

class SimpleGridDemo extends StatelessWidget {
  const SimpleGridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView Demod')),
      backgroundColor: Colors.white,
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          //physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 3 / 4,
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: List.generate(1, (index) {
            return Chord(key: ValueKey(index));
          })),
    );
  }
}
