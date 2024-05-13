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
        Column(children: [
          SizedBox(
              height: 16 * 3,
              child: Scrollbar(
                trackVisibility: true,
                thumbVisibility: true,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: rootChords
                        .map((rootChord) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 4, left: 3, right: 3),
                              child: ElevatedButton(
                                onPressed: () => {
                                  updateFilters(
                                    FiltersModel(root: rootChord),
                                  )
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size.fromWidth(50),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          filters.root == rootChord
                                              ? const Color.fromARGB(
                                                  255, 166, 255, 173)
                                              : const Color(0xFFf9fafa)),
                                  elevation:
                                      MaterialStateProperty.all<double>(0.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: Text(
                                  rootChord,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ))
                        .toList()),
              )),
          SizedBox(
              height: 16 * 3,
              child: Scrollbar(
                trackVisibility: true,
                thumbVisibility: true,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: chordTypes
                        .map((chordType) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 8, left: 3, right: 3),
                              child: ElevatedButton(
                                onPressed: () => {},
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size.fromWidth(50),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 240, 230, 255)),
                                  elevation:
                                      MaterialStateProperty.all<double>(0.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: Text(
                                  chordType,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ))
                        .toList()),
              )),
        ]),
      ],
    );
  }
}
