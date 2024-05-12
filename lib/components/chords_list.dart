import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_drive/audio/chord_player.dart';
import 'package:test_drive/components/chord_widget.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordsList extends StatelessWidget {
  final List<ChordModel> chords;

  const ChordsList({super.key, required this.chords});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        // TODO: Use Builder
        child: ListView(
            children: List.generate(chords.length, (index) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 123, 123, 123)),
            child: Text(
              chords[index].name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: chords[index]
                    .positions
                    .sublist(0, min(chords[index].positions.length, 4))
                    .map((chordPosition) => ChordWidget(
                        key: ValueKey([index, chordPosition]),
                        chordPosition: chordPosition,
                        onTap: () async => {
                              if (Navigator.of(context).canPop())
                                {await ChordPlayer.playChord(chords[index])}
                              else
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChordsList(
                                          chords: chords.sublist(0, 4))))
                                }
                            }))
                    .toList(),
              ))
        ],
      );
    })));
  }
}
