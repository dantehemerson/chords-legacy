import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final ValueChanged<int>? onTap;
  final int currentIndex;

  const BottomBar({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BottomNavigationBar(
      elevation: 1,
      currentIndex: currentIndex,
      selectedItemColor: theme.colorScheme.tertiary,
      showUnselectedLabels: true,
      iconSize: 24,
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 11,
      ),
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.library_books,
          ),
          label: 'Library',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(
        //     Icons.list_alt,
        //   ),
        //   label: 'Collections',
        // ),
      ],
    );
  }
}
