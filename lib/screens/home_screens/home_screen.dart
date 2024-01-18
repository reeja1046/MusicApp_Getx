import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/screens/home_screens/library/favourites.dart';
import 'package:music_app/screens/home_screens/library/library_buttons.dart';
import 'package:music_app/screens/home_screens/library/mostly_played.dart';
import 'package:music_app/screens/home_screens/my_songs.dart';
import 'package:music_app/screens/home_screens/library/recently_played.dart';
import 'package:music_app/screens/widgets/search_screen.dart';

List<Audio> audioList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final box = SongBox.getinstance();
late List<Song> allSongs;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    allSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 30, 56),
          centerTitle: true,
          title: const Text(
            'ChillaX',
            style: TextStyle(fontSize: 35),
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
                  onPressed: const RecentlyPlayedScreen(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                LibraryButtons(
                    title: 'Mostly Played',
                    onPressed: const MostlyPlayedScreen()),
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              LibraryButtons(title: 'Favorites', onPressed: const AddToFav()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  subtitle(name: 'Your Collections'),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(
                              songList: allSongs,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => MySongs(
                  index: index,
                  song: allSongs[index],
                  songlist: const [],
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 10,
                ),
                itemCount: allSongs.length,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  subtitle({required name}) {
    return Text(
      '$name',
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
