import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:test_drive/components/chords_filters.dart';
import 'package:test_drive/components/chords_list.dart';
import 'package:test_drive/components/keyboard_attachable_footer.dart';
import 'package:test_drive/components/search_field.dart';
import 'package:test_drive/extensions/string_extensions.dart';
import 'package:test_drive/generated/l10n.dart';
import 'package:test_drive/models/chord_model.dart';
import 'package:test_drive/models/filters_model.dart';
import 'package:test_drive/utils/locale_utils.dart';
import 'package:test_drive/views/search_results_view.dart';

class SearchView extends StatefulWidget {
  final List<ChordModel> chords;
  final ThemeMode themeMode;
  final Function(ThemeMode) setThemeMode;
  final Function(Locale) setLocale;

  const SearchView(
      {super.key,
      required this.chords,
      required this.themeMode,
      required this.setThemeMode,
      required this.setLocale});

  @override
  State<StatefulWidget> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  FiltersModel filters = FiltersModel();
  TextEditingController txt = TextEditingController();
  FocusNode searchFieldFocusNode = FocusNode();
  bool _isSearching = false;
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    searchFieldFocusNode = FocusNode();
    searchFieldFocusNode.addListener(_handleFocusChange);

    () async {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = packageInfo;
      });
    }();
  }

  void _handleFocusChange() {
    if (searchFieldFocusNode.hasFocus != _isSearching) {
      setState(() {
        _isSearching = searchFieldFocusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    searchFieldFocusNode.removeListener(_handleFocusChange);
    searchFieldFocusNode.dispose();
    super.dispose();
  }

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
    ThemeData theme = Theme.of(context);
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
        appBar: AppBar(
          title: SearchField(
            controller: txt,
            focusNode: searchFieldFocusNode,
            isSearching: _isSearching,
            onChanged: _updateSearchText,
          ),
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
          actions: [
            _isSearching
                ? Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: TextButton(
                      onPressed: () {
                        _updateSearchText('');
                        searchFieldFocusNode.unfocus();
                      },
                      child: Text(S.of(context).action__cancel),
                    ),
                  )
                : MenuAnchor(
                    style: MenuStyle(
                      backgroundColor:
                          WidgetStateProperty.all(theme.colorScheme.secondary),
                      surfaceTintColor:
                          WidgetStateProperty.all(theme.colorScheme.secondary),
                      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    menuChildren: [
                      SubmenuButton(
                        leadingIcon: const Icon(
                          Icons.contrast,
                          size: 16,
                        ),
                        menuStyle: MenuStyle(
                          backgroundColor: WidgetStateProperty.all(
                              theme.colorScheme.secondary),
                          surfaceTintColor: WidgetStateProperty.all(
                              theme.colorScheme.secondary),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.only(top: 0)),
                        ),
                        menuChildren: ThemeMode.values.map((themeMode) {
                          return MenuItemButton(
                            onPressed: () {
                              widget.setThemeMode(themeMode);
                            },
                            leadingIcon: widget.themeMode == themeMode
                                ? const Icon(Icons.check, size: 16)
                                : const SizedBox(width: 12),
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                  const EdgeInsets.only(left: 16, right: 16)),
                            ),
                            child: Text(
                              themeMode.name.capitalize(),
                            ),
                          );
                        }).toList(),
                        child: const Text(
                          'Theme',
                          softWrap: true,
                          style: TextStyle(letterSpacing: 1),
                        ),
                      ),
                      SubmenuButton(
                        leadingIcon: const Icon(
                          Icons.language_outlined,
                          size: 16,
                        ),
                        menuStyle: MenuStyle(
                          backgroundColor: WidgetStateProperty.all(
                              theme.colorScheme.secondary),
                          surfaceTintColor: WidgetStateProperty.all(
                              theme.colorScheme.secondary),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.only(top: 0)),
                        ),
                        menuChildren: S.delegate.supportedLocales.map((locale) {
                          return MenuItemButton(
                            onPressed: () {
                              widget.setLocale(locale);
                            },
                            leadingIcon:
                                Intl.getCurrentLocale() == locale.languageCode
                                    ? const Icon(Icons.check, size: 16)
                                    : const SizedBox(width: 12),
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                  const EdgeInsets.only(left: 16, right: 16)),
                            ),
                            child: Text(
                              locale.languageCode.capitalize() +
                                  (LocaleUtils.isDefaultLocale(locale)
                                      ? '(Default)'
                                      : ''),
                            ),
                          );
                        }).toList(),
                        child: const Text(
                          'Language',
                          softWrap: true,
                          style: TextStyle(letterSpacing: 1),
                        ),
                      ),
                      MenuItemButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: theme.colorScheme.secondary,
                            surfaceTintColor: theme.colorScheme.secondary,
                            content: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      const TextSpan(
                                          text: 'Chords App',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              '\nVersion: ${_packageInfo?.version}'),
                                      const TextSpan(
                                          text:
                                              '\n\n© 2024 Chords App\nAll rights reserved.'),
                                    ])),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                        leadingIcon: const Icon(
                          Icons.info_outline,
                          size: 16,
                        ),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.only(left: 16, right: 16)),
                        ),
                        child: const Text(
                          'About',
                          softWrap: true,
                          style: TextStyle(letterSpacing: 1),
                        ),
                      )
                    ],
                    builder: (BuildContext context, MenuController controller,
                        Widget? child) {
                      return IconButton(
                        icon: const Icon(Icons.more_vert),
                        tooltip: 'Menu options',
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                      );
                    }),
          ],
        ),
        body: (_isSearching || txt.text.isNotEmpty)
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
                      chords: txt.text.trim() == "" ? [] : widget.chords,
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
