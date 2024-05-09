import 'package:flutter/material.dart';
import 'package:test_drive/audio/chord_player.dart';
import 'package:test_drive/components/chord_widget.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordsGrid extends StatelessWidget {
  final List<ChordModel> chords;

  const ChordsGrid({super.key, required this.chords});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chords List'),
          backgroundColor: Colors.blue,
        ),
        body: Scrollbar(
          thumbVisibility: true,
          child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(50),
              mainAxisSpacing: 90,
              crossAxisSpacing: 60,
              childAspectRatio: 3 / 4,
              children: List.generate(chords.length, (index) {
                return ChordWidget(
                    key: ValueKey(index),
                    chord: chords[index],
                    onTap: () async =>
                        {await ChordPlayer.playChord(chords[index])});
              })),
        ));
  }
}
