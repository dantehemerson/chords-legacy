import 'package:flutter/material.dart';
import 'package:test_drive/components/chords_grid.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordDetailView extends StatelessWidget {
  final ChordModel chord;

  const ChordDetailView({super.key, required this.chord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(chord.name),
          surfaceTintColor: Colors.transparent,
        ),
        body: Column(children: [
          Column(children: [
            Text('Name: ${chord.name}'),
            Text('Root: ${chord.root}'),
          ]),
          Expanded(child: ChordsGrid(chordPositions: chord.positions)),
        ]));
  }
}
