import 'package:get/get.dart';
import 'package:music_app/view/screens/favorites/favourites.dart';
import 'package:music_app/view/screens/homescreen/home_screen.dart';
import 'package:music_app/view/screens/playlist/playlist.dart';
import 'package:music_app/view/screens/settings/settings.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;
  var isRepeat = false.obs;
  var isShuffle = false.obs;

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  final pages = [
    const HomeScreen(),
    const Addtofavorites(),
    const AllPlaylist(),
    const MainSettings(),
  ];
}
