import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/favorites_controller.dart';
import 'package:music_app/controller/mostly_controller.dart';
import 'package:music_app/controller/recently_%20controller.dart';
import 'package:music_app/model/song_model/song_model.dart';
import 'package:music_app/view/screens/playlist/create_playlist.dart';
import 'package:music_app/view/widgets/main_play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class RecentlyListView extends StatelessWidget {
  dynamic currentSong;
  List<Audio> convertAudios;
  int index;
  // final List<RecentlyPlayed> recentdbsongs;
  RecentlyListView(
      {super.key,
      required this.convertAudios,
      required this.index,
      required this.currentSong});

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final RecentlyPlayedController recentlyController =
        Get.put(RecentlyPlayedController());
    final MostlyPlayedController mostlyController =
        Get.put(MostlyPlayedController());
    final FavoriteController favController = Get.put(FavoriteController());

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.black,
      onTap: () {
        audioPlayer.open(
          Playlist(
            audios: convertAudios,
            startIndex: index,
          ),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
          showNotification: true,
          loopMode: LoopMode.playlist,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NowPlaying(
                  index: index,
                  nowPlayList: convertAudios,
                )));
                
        print(recentlyController.recentlyplayeddbsongs.length);
        print("Index: $index, Song Count: ${convertAudios.length}");

        RecentlyPlayed recentlySong;
        MostlyPlayed mostlySong;
        recentlySong = RecentlyPlayed(
            title: currentSong.title,
            artist: currentSong.artist,
            duration: currentSong.duration,
            songurl: currentSong.songurl,
            id: currentSong.id);

        recentlyController.addRecently(recentlySong);
        mostlySong = MostlyPlayed(
            title: currentSong.title,
            artist: currentSong.artist,
            duration: currentSong.duration,
            songurl: currentSong.songurl,
            id: currentSong.id,
            count: 1);
        mostlyController.updateMostlyPlayedSongs(mostlySong);
      },
      leading: QueryArtworkWidget(
        artworkFit: BoxFit.cover,
        id: currentSong.id!,
        type: ArtworkType.AUDIO,
        artworkQuality: FilterQuality.high,
        size: 2000,
        quality: 100,
        artworkBorder: BorderRadius.circular(10),
        nullArtworkWidget: Container(
          width: MediaQuery.of(context).size.width * 0.134,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/All_songs_logo.jpeg')),
          ),
        ),
      ),
      title: Text(
        currentSong.title!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      subtitle: currentSong.artist == '<unknown>'
          ? const Text(
              'Unknown Artist',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )
          : Text(
              currentSong.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
              child: TextButton(
            onPressed: () {
              favController.addToFavorite(currentSong.id, context);
              Navigator.of(context).pop();
            },
            child: Text(favController.isalready(currentSong.id)
                ? 'Remove from favorites'
                : 'Add to favorites'),
          )),
          PopupMenuItem(
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CreatePlaylist(song: currentSong)));
                                },
                                child: const Text('Create New Playlist')),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Add to existing Playlist')),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.playlist_add_outlined),
              label: const Text('Add to Playlist'),
            ),
          ),
        ],
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
    );
  }
}
