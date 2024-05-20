import 'package:flutter/material.dart';
import 'package:test_drive/data/chord_notes_constant.dart';
import 'package:test_drive/models/filters_model.dart';

class ChordsFilter extends StatelessWidget {
  final FiltersModel filters;
  final void Function(FiltersModel) updateFilters;

  const ChordsFilter(
      {super.key, required this.filters, required this.updateFilters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16 * 3,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                  children: rootChords
                      .map((rootChord) => Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 4, left: 3, right: 3),
                            child: ElevatedButton(
                              onPressed: () => {
                                updateFilters(
                                  filters.copyWith(root: rootChord),
                                )
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                  const Size.fromWidth(50),
                                ),
                                elevation:
                                    MaterialStateProperty.all<double>(0.0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: (filters.root == rootChord
                                                  ? Colors.blue[700]
                                                  : Colors.grey.shade400) ??
                                              Colors.transparent,
                                          width: 1.8)),
                                ),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.zero,
                                ),
                              ),
                              child: Text(
                                rootChord,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: (filters.root == rootChord
                                          ? Colors.blue[700]
                                          : Colors.grey.shade700) ??
                                      Colors.transparent,
                                ),
                              ),
                            ),
                          ))
                      .toList())),
        ),
        SizedBox(
            height: 16 * 2.8,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: chordTypes
                      .map((chordType) => Padding(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 8, left: 3, right: 3),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!filters.hasFilterType(chordType)) {
                                  updateFilters(
                                    filters.copyWith().addFilterType(chordType),
                                  );
                                } else {
                                  updateFilters(
                                    filters
                                        .copyWith()
                                        .removeFilterType(chordType),
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        filters.hasFilterType(chordType)
                                            ? Colors.red
                                            : const Color.fromARGB(
                                                255, 240, 230, 255)),
                                elevation:
                                    MaterialStateProperty.all<double>(0.0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.zero,
                                ),
                              ),
                              child: Text(
                                chordType,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ))
                      .toList()),
            )),
      ],
    );
  }
}
