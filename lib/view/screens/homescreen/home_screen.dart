import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/home_controller.dart';
import 'package:music_app/view/screens/homescreen/widgets/allsongslist.dart';
import 'package:music_app/view/screens/homescreen/widgets/library_buttons.dart';
import 'package:music_app/view/screens/mostlyplayed/mostly_played.dart';
import 'package:music_app/view/screens/recentlyplayed/recently_played.dart';
import 'package:music_app/view/screens/searchscreen/search_screen.dart';

List<Audio> audioList = [];
// List<Song> allSongs = box.values.toList();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Seraphine',
            style: TextStyle(fontSize: 30, color: Colors.black),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              subtitle(name: 'Library'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                LibraryButtons(
                  title: 'Recently Played',
                  onPressed: () => Get.to(() => const RecentlyPlayedScreen()),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                LibraryButtons(
                  title: 'Mostly Played',
                  onPressed: () => Get.to(() => const MostlyPlayedScreen()),
                ),
              ]),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  subtitle(name: 'Your Collections'),
                  IconButton(
                      onPressed: () {
                        Get.to(() =>
                            SearchScreen(songList: homeController.dbAllSongs));
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 25,
                      ))
                ],
              ),
              const AllSongsList(),
            ]),
          ),
        ),
      ),
    );
  }

  subtitle({required name}) {
    return Text(
      '$name',
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
  }
}
