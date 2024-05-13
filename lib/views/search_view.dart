import 'package:flutter/material.dart';
import 'package:test_drive/components/chords_filters.dart';
import 'package:test_drive/components/chords_list.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/models/filters_model.dart';

class SearchView extends StatefulWidget {
  final List<ChordModel> chords;

  const SearchView({super.key, required this.chords});

  @override
  State<StatefulWidget> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  FiltersModel filters = FiltersModel();

  void _updateFilters(FiltersModel newFilters) {
    setState(() {
      filters = newFilters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chords List'),
          backgroundColor: Colors.blue,
        ),
        body: Column(children: [
          ChordsFilter(
            filters: filters,
            updateFilters: _updateFilters,
          ),
          Expanded(
              child: ChordsList(
                  chords: widget.chords
                      .where((chord) => filters.isChordInFilter(chord))
                      .toList()))
        ]));
  }
}
