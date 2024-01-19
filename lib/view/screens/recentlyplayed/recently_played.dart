import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/recently_%20controller.dart';
import 'package:music_app/database/functions/db_func.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/view/screens/recentlyplayed/recently_listtile.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

AssetsAudioPlayer audioPlayers = AssetsAudioPlayer.withId('0');
List<Audio> convertAudio = [];

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  List<RecentlyPlayed> recentdbsongs =
      recentplayeddb.values.toList().reversed.toList();
  @override
  void initState() {
    for (var element in recentdbsongs) {
      convertAudio.add(
        Audio.file(
          element.songurl!,
          metas: Metas(
            title: element.title,
            artist: element.artist,
            id: element.id.toString(),
          ), 
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RecentlyPlayedController recentlyPlayedController =
        Get.put(RecentlyPlayedController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Recently Played',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          if (recentdbsongs.isNotEmpty)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: const Text('Are You Sure?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            recentlyPlayedController.clearRecentlyPlayedSongs();
                            recentdbsongs.clear();
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Cleared Your Songs'),
                                duration: Duration(milliseconds: 600),
                              ),
                            );
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.clear),
            ),
        ],
      ),
      body: SafeArea(
        child: RecentlyListView(recentdbsongs: recentdbsongs),
      ),
    );
  }
}
