import 'package:test_drive/models/chord_model.dart';

class FiltersModel {
  final String root;
  List<String> types;

  FiltersModel({
    this.root = "C",
    List<String>? types,
  }) : types = types ?? [];

  FiltersModel addFilterType(String type) {
    if (!types.contains(type)) {
      return FiltersModel(
        root: this.root,
        types: List.from(this.types)..add(type),
      );
    }
    return this;
  }

  FiltersModel removeFilterType(String type) {
    if (types.contains(type)) {
      List<String> updatedTypes = List.from(this.types)..remove(type);
      return FiltersModel(
        root: this.root,
        types: updatedTypes,
      );
    }
    return this;
  }

  bool hasFilterType(String type) {
    return types.contains(type);
  }

  bool isChordInFilter(ChordModel chord) {
    return root == chord.root;
  }

  Map<String, dynamic> toJson() {
    return {
      'positions': root,
      'types': types,
    };
  }

  // implement copyWith method
  FiltersModel copyWith({
    String? root,
    List<String>? types,
  }) {
    return FiltersModel(
      root: root ?? this.root,
      types: types ?? this.types,
    );
  }
}
