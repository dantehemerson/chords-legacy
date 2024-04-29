import 'package:flutter/material.dart';
import 'package:test_drive/components/chord_widget.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordsGrid extends StatelessWidget {
  final List<ChordModel> chords;

  const ChordsGrid({super.key, required this.chords});

  @override
  Widget build(BuildContext context) {
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
            return ChordWidget(key: ValueKey(index), chord: chords[index]);
          })),
    );
  }
}
