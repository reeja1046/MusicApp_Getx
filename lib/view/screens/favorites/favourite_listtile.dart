// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:marquee_widget/marquee_widget.dart';
// import 'package:music_app/database/functions/db_functions.dart';
// import 'package:music_app/database/functions/fav_db_functions.dart';
// import 'package:music_app/database/model/song_model.dart';
// import 'package:music_app/view/screens/homescreen/home_screen.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import '../../widgets/main_play_screen.dart';

// // ignore: must_be_immutable
// class Favouritelist extends StatefulWidget {
//   final FavSongs song;
//   List<FavSongs> songlist;
//   final Color? color;
//   final int index;
//   Favouritelist(
//       {super.key,
//       required this.song,
//       required this.songlist,
//       this.color,
//       required this.index});

//   @override
//   State<Favouritelist> createState() => _FavouritelistState();
// }

// class _FavouritelistState extends State<Favouritelist> {
//   bool isfav = false;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       tileColor: widget.color ?? Colors.black,
//       onTap: () {
//         RecentlyPlayed recentlySong;
//         recentlySong = RecentlyPlayed(
//             title: widget.song.title,
//             artist: widget.song.artist,
//             duration: widget.song.duration,
//             songurl: widget.song.songurl,
//             id: widget.song.id);

//         MostlyPlayed mostlySong;
//         mostlySong = MostlyPlayed(
//             title: widget.song.title,
//             artist: widget.song.artist,
//             duration: widget.song.duration,
//             songurl: widget.song.songurl,
//             id: widget.song.id,
//             count: 1);
//         // addRecently(recentlySong);
//         // addMostly(mostlySong);

//         audioPlayer.stop();
//         audioList.clear();
//         for (FavSongs item in widget.songlist) {
//           audioList.add(Audio.file(item.songurl!,
//               metas: Metas(
//                 title: item.title,
//                 artist: item.artist,
//                 id: item.id.toString(),
//               )));
//         }
//         playingaudio(context, widget.index, widget.songlist);
//       },
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       leading: QueryArtworkWidget(
//         id: widget.song.id!,
//         size: 3000,
//         artworkFit: BoxFit.cover,
//         type: ArtworkType.AUDIO,
//         artworkBorder: BorderRadius.circular(10),
//         artworkQuality: FilterQuality.high,
//         nullArtworkWidget: Image(
//           height: MediaQuery.of(context).size.height * 0.07,
//           width: MediaQuery.of(context).size.height * 0.07,
//           image: const AssetImage(
//             'assets/images/All_songs_logo.jpeg',
//           ),
//         ),
//       ),
//       title: Marquee(
//         animationDuration: const Duration(milliseconds: 6500),
//         directionMarguee: DirectionMarguee.oneDirection,
//         pauseDuration: const Duration(milliseconds: 1000),
//         child: Text(
//           widget.song.title!,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       subtitle: Text(widget.song.artist.toString(),
//           style: const TextStyle(color: Colors.white)),
//       trailing: IconButton(
//           onPressed: () {
//             // setState(() {});
//             // addToFavorite(widget.song.id, context);
//           },
//           icon: const Icon(Icons.delete, color: Colors.white)),
//     );
//   }
// }

// playingaudio(context, int index, songList) async {
//   await audioPlayer.open(Playlist(audios: audioList, startIndex: index));
//   Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => NowPlaying(
//             index: index,
//             nowPlayList: songList,
//           )));
// }

import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/favorites_controller.dart';
import 'package:music_app/controller/mostly_controller.dart';
import 'package:music_app/controller/recently_%20controller.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/view/widgets/main_play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavListView extends StatelessWidget {
  final List<FavSongs> favdbsongs;
  List<Audio> convertAudios;

  FavListView(
      {super.key, required this.favdbsongs, required this.convertAudios});

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    final MostlyPlayedController mostlyController =
        Get.put(MostlyPlayedController());

    final RecentlyPlayedController recentlyController =
        Get.put(RecentlyPlayedController());
    final FavoriteController favController = Get.put(FavoriteController());
    return (favdbsongs.isEmpty)
        ? const Center(
            child: Text(
              "You haven't liked anything ! ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favdbsongs.length,
              itemBuilder: (context, index) {
                if (index == favdbsongs.length) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  );
                }
                FavSongs currentSong = favdbsongs[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.black,
                  onTap: () {
                    audioPlayer.open(
                      Playlist(
                        audios: convertAudios,
                        startIndex: index,
                      ),
                      headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                      showNotification: true,
                      loopMode: LoopMode.playlist,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NowPlaying(
                          index: index,
                          nowPlayList: convertAudios,
                        ),
                      ),
                    );
                    print(favController.favDbSongs.length);

                    MostlyPlayed mostlySong;
                    mostlySong = MostlyPlayed(
                        title: currentSong.title,
                        artist: currentSong.artist,
                        duration: currentSong.duration,
                        songurl: currentSong.songurl,
                        count: 1,
                        id: currentSong.id);

                    mostlyController.updateMostlyPlayedSongs(mostlySong);

                    RecentlyPlayed recentlyPlayed;
                    recentlyPlayed = RecentlyPlayed(
                        title: currentSong.title,
                        artist: currentSong.artist,
                        duration: currentSong.duration,
                        songurl: currentSong.songurl,
                        id: currentSong.id);
                    recentlyController.addRecently(recentlyPlayed);
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
                  trailing: IconButton(
                    onPressed: () {
                      log('nxjschdcdvfd');
                      int songIdToDelete = currentSong.id!;
                      favController.removeFav(songIdToDelete, context);
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 10),
            ),
          );
  }
}
