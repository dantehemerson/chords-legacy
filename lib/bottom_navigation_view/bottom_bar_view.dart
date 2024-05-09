import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final ValueChanged<int>? onTap;
  final int currentIndex;

  const BottomBar({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 1,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.black,
      selectedItemColor: const Color.fromARGB(255, 28, 104, 227),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      showUnselectedLabels: true,
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
            Icons.collections,
          ),
          label: 'Collections',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          label: 'Favorites',
        ),
      ],
    );
  }
}
