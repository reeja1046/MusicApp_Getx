import 'package:flutter/material.dart';
import 'package:music_app/view/screens/homescreen/home_screen.dart';
import 'package:music_app/view/screens/favorites/favourites.dart';
import 'package:music_app/view/screens/playlist/playlist.dart';
import 'package:music_app/view/screens/settings/settings.dart';

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
    const AddToFav(),
    const AllPlaylist(),
    const MainSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: SuperBottomNavigationBar(
        backgroundColor: Colors.black,
        items: const [
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.home_outlined,
              selectedIcon: Icons.home,
              splashColor: Colors.redAccent,
              borderBottomColor: Colors.redAccent,
              selectedIconColor: Colors.redAccent,
              unSelectedIconColor: Colors.grey),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.favorite_border,
              selectedIcon: Icons.favorite,
              splashColor: Colors.redAccent,
              borderBottomColor: Colors.redAccent,
              selectedIconColor: Colors.redAccent,
              unSelectedIconColor: Colors.grey),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.playlist_add,
              selectedIcon: Icons.playlist_add_check,
              splashColor: Colors.redAccent,
              borderBottomColor: Colors.redAccent,
              selectedIconColor: Colors.redAccent,
              unSelectedIconColor: Colors.grey),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              splashColor: Colors.redAccent,
              borderBottomColor: Colors.redAccent,
              selectedIconColor: Colors.redAccent,
              unSelectedIconColor: Colors.white),
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
