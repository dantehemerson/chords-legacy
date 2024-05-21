import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final void Function(String) onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSearching;

  const SearchField(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.isSearching,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
        margin: const EdgeInsets.only(left: 16, right: 4),
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          focusNode: focusNode,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: isSearching,
          onChanged: (s) => {onChanged(s)},
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: theme.colorScheme.primary == Colors.white
                  ? (isSearching ? Colors.white : Colors.white.withAlpha(140))
                  : theme.colorScheme.primary,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: theme.colorScheme.primary == Colors.white
                    ? Colors.white.withAlpha(100)
                    : theme.colorScheme.primary,
                width: 2,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            hintText: 'Search for chords or collections',
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ));
  }
}
