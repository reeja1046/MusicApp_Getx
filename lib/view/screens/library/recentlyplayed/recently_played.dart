import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/recently_%20controller.dart';
import 'package:music_app/view/screens/library/recentlyplayed/recently_listtile.dart';

AssetsAudioPlayer audioPlayers = AssetsAudioPlayer.withId('0');
List<Audio> convertAudio = [];

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

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
          Obx(
            () => recentlyPlayedController.recentlyplayeddbsongs.isNotEmpty
                ? IconButton(
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
                                onPressed: () {
                                  recentlyPlayedController
                                      .clearRecentlyPlayedSongs();
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
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: RecentlyListView(
            recentdbsongs: recentlyPlayedController.recentlyplayeddbsongs),
      ),
    );
  }
}