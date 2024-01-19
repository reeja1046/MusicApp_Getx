
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/database/functions/db_functions.dart';
import 'package:music_app/database/functions/fav_db_functions.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/view/screens/playlist/create_playlist.dart';
import 'package:music_app/view/screens/recentlyplayed/recently_played.dart';
import 'package:music_app/view/widgets/main_play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyListView extends StatelessWidget {
  final List<RecentlyPlayed> recentdbsongs;
  const RecentlyListView({super.key, required this.recentdbsongs});

  @override
  Widget build(BuildContext context) {
    final box = RecentlyPlayedBox.getinstance();

    return (recentdbsongs.isEmpty)
        ? const Center(
            child: Text(
              "You haven't played anything ! ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentdbsongs.length,
              itemBuilder: (context, index) {
                if (index == recentdbsongs.length) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  );
                }
                RecentlyPlayed currentSong = recentdbsongs[index];
                return ListTile(
                  tileColor: Colors.black,
                  onTap: () {
                    RecentlyPlayed recentlySong;
                    recentlySong = RecentlyPlayed(
                        title: currentSong.title,
                        artist: currentSong.artist,
                        duration: currentSong.duration,
                        songurl: currentSong.songurl,
                        id: currentSong.id);

                    addRecently(recentlySong);

                    audioPlayers.open(
                      Playlist(
                        audios: convertAudio,
                        startIndex: index,
                      ),
                      headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                      showNotification: true,
                      loopMode: LoopMode.playlist,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NowPlaying(
                              index: index,
                              nowPlayList: recentdbsongs,
                            )));
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
                            image: AssetImage(
                                'assets/images/All_songs_logo.jpeg')),
                      ),
                    ),
                  ),
                  title: Text(
                    currentSong.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
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
                          addToFavorite(currentSong.id, context);
                          Navigator.of(context).pop();
                        },
                        child: Text(isalready(currentSong.id)
                            ? 'Remove from favourites'
                            : 'Add to favourites'),
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
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreatePlaylist(
                                                              song:
                                                                  currentSong)));
                                            },
                                            child: const Text(
                                                'Create New Playlist')),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                                'Add to existing Playlist')),
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
              },
              separatorBuilder: (context, index) => const Divider(height: 10),
            ),
          );
  }
}