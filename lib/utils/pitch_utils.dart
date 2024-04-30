class PitchUtils {
  static const midiPitches = {
    6: 40,
    5: 45,
    4: 50,
    3: 55,
    2: 59,
    1: 64,
  };

  static int getMidiNumberFromFret(int string, int fret) {
    return midiPitches[string]! + fret;
  }
}
