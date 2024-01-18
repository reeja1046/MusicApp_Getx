import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/bottomnavbar_controller.dart';
import 'package:super_bottom_navigation_bar/super_bottom_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  final NavbarController controller = Get.put(NavbarController());

  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: SuperBottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: controller.selectedIndex.value,
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
          controller.changeSelectedIndex(index);
        },
      ),
    );
  }
}
