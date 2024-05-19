import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:test_drive/components/chords_filters.dart';
import 'package:test_drive/components/chords_list.dart';
import 'package:test_drive/components/keyboard_attachable_footer.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/models/filters_model.dart';
import 'package:test_drive/views/search_results_view.dart';

class SearchView extends StatefulWidget {
  final List<ChordModel> chords;

  const SearchView({super.key, required this.chords});

  @override
  State<StatefulWidget> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  FiltersModel filters = FiltersModel();
  bool _isSearchOpen = true;
  TextEditingController txt = TextEditingController();

  void _updateSearchText(String newText) {
    setState(() {
      txt.text = newText;
    });
  }

  void _updateFilters(FiltersModel newFilters) {
    setState(() {
      filters = newFilters;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
        appBar: AppBar(
          title: Container(
              margin: const EdgeInsets.only(left: 16, right: 4),
              child: TextField(
                  controller: txt,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  onChanged: (s) => {_updateSearchText(s)},
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              width: 0,
                              color: Color.fromARGB(255, 252, 252, 252))),
                      hintText: 'Search for chords or collections',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 103, 119, 131)),
                      contentPadding: EdgeInsets.only(left: 20, right: 20),
                      filled: true,
                      fillColor: Colors.white),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 16))),
          backgroundColor: Colors.white,
          titleSpacing: 0,
          actions: [
            _isSearchOpen
                ? Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isSearchOpen = false;
                        });
                      },
                      child: const Text('Cancel'),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      setState(() {
                        _isSearchOpen = !_isSearchOpen;
                      });
                    },
                  )
          ],
        ),
        body: _isSearchOpen
            ? SafeArea(
                maintainBottomViewPadding: true,
                child: FooterLayout(
                    footer: isKeyboardVisible
                        ? KeyboardAttachableFooter(
                            onTap: (s) {
                              _updateSearchText(txt.text + s);
                            },
                          )
                        : null,
                    child: SearchResultsView(
                      chords: widget.chords,
                    )))
            : Column(children: [
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
