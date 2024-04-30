import 'package:flutter_midi_pro/flutter_midi_pro.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/utils/pitch_utils.dart';

class ChordPlayer {
  static final MidiPro midiPro = MidiPro();
  static int? soundFontId;

  static playChord(ChordModel chord) async {
    soundFontId ??= await MidiPro().loadSoundfont(
        path: 'assets/sounds/guitar_acoustic.sf2', bank: 0, program: 0);

    final midiNotes = getMidiNotesFromFrets(chord);
    print('Playing chord ${midiNotes.toString()}');

    for (final midiNote in midiNotes) {
      await Future.delayed(const Duration(milliseconds: 40));
      await MidiPro().playNote(
          sfId: soundFontId!, channel: 0, key: midiNote, velocity: 127);
    }
  }

  static List<int> getMidiNotesFromFrets(ChordModel chord) {
    final List<int> midiNumbers = [];

    for (int i = 0; i < chord.notes.length; i++) {
      final string = 6 - i;
      if (chord.notes[i].fret != null) {
        midiNumbers.add(
            PitchUtils.getMidiNumberFromFret(string, chord.notes[i].fret!));
      }
    }

    return midiNumbers;
  }
}
