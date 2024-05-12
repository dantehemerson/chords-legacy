import 'package:flutter/material.dart';
import 'package:test_drive/audio/chord_player.dart';
import 'package:test_drive/components/chord_widget.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordsGrid extends StatelessWidget {
  final List<ChordPosition> chordPositions;

  const ChordsGrid({super.key, required this.chordPositions});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(50),
      mainAxisSpacing: 90,
      crossAxisSpacing: 60,
      childAspectRatio: 3 / 4,
      children: List.generate(chordPositions.length, (index) {
        return ChordWidget(
            key: ValueKey(index),
            chordPosition: chordPositions[index],
            onTap: () async => {
                  {await ChordPlayer.playChord(chordPositions[index])}
                });
      }),
    );
  }
}
