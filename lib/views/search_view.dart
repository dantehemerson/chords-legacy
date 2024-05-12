import 'package:flutter/material.dart';
import 'package:test_drive/components/chords_list.dart';
import 'package:test_drive/models/chord_model.dart';

class SearchView extends StatelessWidget {
  final List<ChordModel> chords;

  const SearchView({super.key, required this.chords});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chords List'),
          backgroundColor: Colors.blue,
        ),
        body: ChordsList(chords: chords));
  }
}
