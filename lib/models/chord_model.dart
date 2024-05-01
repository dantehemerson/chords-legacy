class ChordModel {
  final String id;
  final String name;
  final String root;
  final List<ChordPosition> positions;

  ChordModel({
    required this.id,
    required this.name,
    required this.root,
    required this.positions,
  });

  factory ChordModel.fromJson(Map<String, dynamic> json) {
    return ChordModel(
      id: json['id'],
      name: json['name'],
      root: json['root'],
      positions: (json['positions'] as List<dynamic>)
          .map((note) => ChordPosition(
                frets: note['frets'],
                fingers: note['fingers'],
                baseFret: note['baseFret'],
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'root': root,
      'notes': positions.map((position) => position.toJson()).toList(),
    };
  }
}

class ChordPosition {
  final String frets;
  final String fingers;
  final int baseFret;

  ChordPosition(
      {required this.frets, required this.fingers, required this.baseFret});

  Map<String, dynamic> toJson() {
    return {
      'frets': frets,
      'fingers': fingers,
      'baseFret': baseFret,
    };
  }
}
