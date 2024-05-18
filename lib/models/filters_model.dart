import 'package:test_drive/models/chord_model.dart';

class FiltersModel {
  final String root;

  FiltersModel({
    this.root = "C",
  });

  bool isChordInFilter(ChordModel chord) {
    return root == chord.root;
  }

  Map<String, dynamic> toJson() {
    return {
      'positions': root,
    };
  }
}
