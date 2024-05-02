import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/audio/chord_player.dart';
import 'package:test_drive/models/chord_model.dart';

void main() {
  group('ChordPlayer', () {
    test('getMidiNotes returns correct MIDI notes', () {
      ChordModel chord1 = ChordModel(
        id: 'bb8891e8fbed6ade9e6239197aef85c86227abc197ddf7452e46bcb16e9a9970',
        name: 'C 69',
        root: 'C',
        positions: [
          ChordPosition(
            frets: 'x22122',
            fingers: '022134',
            baseFret: 9,
          ),
        ],
      );

      final midiNotes = ChordPlayer.getMidiNotes(chord1);

      expect(midiNotes.length, equals(5));
      expect(midiNotes, equals([55, 60, 64, 69, 74]));
    });
  });
}
