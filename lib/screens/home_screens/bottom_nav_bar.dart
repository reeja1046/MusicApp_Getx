import 'package:flutter/material.dart';
import 'package:music_app/screens/home_screens/home_screen.dart';
import 'package:music_app/screens/playlist/playlist.dart';
import 'package:music_app/screens/settings_screens/settings.dart';

import 'package:super_bottom_navigation_bar/super_bottom_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  final _pages = [
    const HomeScreen(),
    // SearchScreen(),
    const AllPlaylist(),
    const MainSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: SuperBottomNavigationBar(
        items: const [
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.home_outlined,
              selectedIcon: Icons.home,
              splashColor: Colors.blue,
              borderBottomColor: Colors.blue,
              backgroundShadowColor: Colors.white,
              selectedIconColor: Colors.blue,
              unSelectedIconColor: Colors.grey),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.playlist_add,
              selectedIcon: Icons.playlist_add_check,
              splashColor: Colors.blue,
              borderBottomColor: Colors.blue,
              backgroundShadowColor: Colors.white,
              selectedIconColor: Colors.blue,
              unSelectedIconColor: Colors.grey),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              splashColor: Colors.blue,
              borderBottomColor: Colors.blue,
              backgroundShadowColor: Colors.white,
              selectedIconColor: Colors.blue,
              unSelectedIconColor: Colors.grey),
        ],
        onSelected: (index) {
          if (index >= 0 && index < _pages.length) {
            setState(() {
              selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
