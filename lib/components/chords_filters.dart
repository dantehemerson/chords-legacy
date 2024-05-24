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
    ThemeData theme = Theme.of(context);

    return Material(
        elevation: 0.1,
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                SizedBox(
                  height: 16 * 2.5,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                          children: rootChords
                              .map((rootChord) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 2, left: 0, right: 6),
                                    child: ElevatedButton(
                                      onPressed: () => {
                                        updateFilters(
                                          filters.copyWith(root: rootChord),
                                        )
                                      },
                                      style: ButtonStyle(
                                        minimumSize:
                                            WidgetStateProperty.all<Size>(
                                          const Size.fromWidth(50),
                                        ),
                                        elevation:
                                            WidgetStateProperty.all<double>(
                                                0.0),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                  color: (filters.root ==
                                                          rootChord
                                                      ? theme
                                                          .colorScheme.tertiary
                                                      : theme
                                                          .colorScheme.primary
                                                          .withOpacity(0.3)),
                                                  width: 1.8)),
                                        ),
                                        padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.zero,
                                        ),
                                      ),
                                      child: Text(
                                        rootChord,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: (filters.root == rootChord
                                                ? theme.primaryColor
                                                : theme.primaryColor
                                                    .withOpacity(0.7))),
                                      ),
                                    ),
                                  ))
                              .toList())),
                ),
                SizedBox(
                    height: 16 * 2.3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                          children: chordTypes
                              .map((chordType) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 6, left: 0, right: 6),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (!filters.hasFilterType(chordType)) {
                                          updateFilters(
                                            filters
                                                .copyWith()
                                                .addFilterType(chordType),
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
                                            WidgetStateProperty.all<Color>(
                                                filters.hasFilterType(chordType)
                                                    ? theme.colorScheme.tertiary
                                                    : theme.colorScheme.primary
                                                        .withOpacity(0.2)),
                                        elevation:
                                            WidgetStateProperty.all<double>(
                                                0.0),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.zero,
                                        ),
                                      ),
                                      child: Text(
                                        chordType,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                filters.hasFilterType(chordType)
                                                    ? Colors.white
                                                    : theme.colorScheme.primary
                                                        .withOpacity(0.5)),
                                      ),
                                    ),
                                  ))
                              .toList()),
                    )),
              ],
            )));
  }
}
