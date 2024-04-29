class ChordModel {
  final String id;
  final String name;
  final String root;
  final String tuning;
  final List<ChordNote> notes;

  ChordModel({
    required this.id,
    required this.name,
    required this.root,
    required this.tuning,
    required this.notes,
  });

  factory ChordModel.fromJson(Map<String, dynamic> json) {
    return ChordModel(
      id: json['id'],
      name: json['name'],
      root: json['root'],
      tuning: json['tuning'],
      notes: (json['notes'] as List<dynamic>)
          .map((note) => ChordNote(
                fret: note['fret'],
                finger: note['finger'],
              ))
          .toList(),
    );
  }
}

class ChordNote {
  final int? fret;
  final int? finger;

  ChordNote({this.fret, this.finger});
}
