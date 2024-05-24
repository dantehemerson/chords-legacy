import 'package:flutter/material.dart';
import 'package:test_drive/components/chords_list.dart';
import 'package:test_drive/models/chord_model.dart';

enum SearchType { all, chords, collections }

class SearchResultsView extends StatefulWidget {
  final List<ChordModel> chords;
  const SearchResultsView({super.key, required this.chords});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  SearchType searchTypeSelected = SearchType.all;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //     padding:
        //         const EdgeInsets.only(left: 40, right: 40, top: 8, bottom: 8),
        //     child: SizedBox(
        //         width: double.infinity,
        //         child: SegmentedButton(
        //           segments: const [
        //             ButtonSegment(
        //                 value: SearchType.all,
        //                 label: Text(
        //                   'All',
        //                 )),
        //             ButtonSegment(
        //                 value: SearchType.chords, label: Text('Chords')),
        //             ButtonSegment(
        //                 value: SearchType.collections,
        //                 label: Text('Collections')),
        //           ],
        //           showSelectedIcon: false,
        //           selected: {searchTypeSelected},
        //           style: ButtonStyle(
        //               alignment: Alignment.center,
        //               padding:
        //                   WidgetStateProperty.all(const EdgeInsets.all(0))),
        //           onSelectionChanged: (newSelection) {
        //             setState(() {
        //               searchTypeSelected = newSelection.first;
        //             });
        //           },
        //         ))),
        Expanded(child: ChordsList(chords: widget.chords.toList()))
      ],
    );
  }
}
