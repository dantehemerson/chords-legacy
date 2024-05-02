import 'package:flutter_midi_pro/flutter_midi_pro.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/utils/pitch_utils.dart';

class ChordPlayer {
  static final MidiPro midiPro = MidiPro();
  static int? soundFontId;

  static playChord(ChordModel chord) async {
    soundFontId ??= await MidiPro().loadSoundfont(
        path: 'assets/sounds/guitar_acoustic.sf2', bank: 0, program: 0);

    final midiNotes = getMidiNotes(chord);
    print('Playing chord ${midiNotes.toString()}');

    for (final midiNote in midiNotes) {
      await Future.delayed(const Duration(milliseconds: 40));
      await MidiPro().playNote(
          sfId: soundFontId!, channel: 0, key: midiNote, velocity: 127);
    }
  }

  static List<int> getMidiNotes(ChordModel chord) {
    final List<int> midiNumbers = [];

    final position = chord.positions[0];

    for (int i = 0; i < 6; i++) {
      final string = 6 - i;
      if (position.frets[i] != 'x') {
        final relativeFret = int.parse(position.frets[i]);
        final fret = relativeFret == 0
            ? relativeFret
            : position.baseFret + relativeFret - 1;

        midiNumbers.add(PitchUtils.getMidiNumberFromFret(string, fret));
      }
    }

    return midiNumbers;
  }
}
