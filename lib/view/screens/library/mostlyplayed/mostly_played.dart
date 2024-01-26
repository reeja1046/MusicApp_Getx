// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:music_app/database/functions/db_func.dart';
// import 'package:music_app/database/functions/db_functions.dart';
// import 'package:music_app/database/functions/fav_db_functions.dart';
// import 'package:music_app/database/model/song_model.dart';
// import 'package:music_app/view/screens/playlist/create_playlist.dart';
// import 'package:music_app/view/screens/homescreen/widgets/appbar_widget.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import '../../../widgets/main_play_screen.dart';

// class MostlyPlayedScreen extends StatefulWidget {
//   const MostlyPlayedScreen({super.key});

//   @override
//   State<MostlyPlayedScreen> createState() => _MostlyPlayedScreenState();
// }

// AssetsAudioPlayer audioPlayers = AssetsAudioPlayer.withId('0');
// List<Audio> convertMAudio = [];

// class _MostlyPlayedScreenState extends State<MostlyPlayedScreen> {
//   List<MostlyPlayed> mostdbsongs =
//       mostlyplayeddb.values.toList().reversed.toList();
//   List<MostlyPlayed> mostlySongs = [];
//   @override
//   void initState() {
//     int i = 0;
//     for (var element in mostdbsongs) {
//       if (element.count! > 5) {
//         mostlySongs.remove(element);
//         mostlySongs.insert(i, element);
//         mostlySongs.sort((a, b) => b.count!.compareTo(a.count!));
//         i++;
//       }
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               ScreenAppbarWidget(
//                 title: 'Mostly Played',
//                 songList: mostlySongs,
//               ),
//               if (mostlySongs.isNotEmpty)
//                 TextButton(
//                     onPressed: () {
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext ctx) {
//                             return AlertDialog(
//                               title: const Text('Are You Sure?'),
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.of(ctx).pop();
//                                     },
//                                     child: const Text('Cancel')),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       mostlyplayeddb.clear();
//                                       mostdbsongs.clear();
//                                       setState(() {});
//                                       Navigator.of(ctx).pop();
//                                       ScaffoldMessenger.of(ctx).showSnackBar(
//                                         const SnackBar(
//                                           content: Text('Cleared Your Songs'),
//                                           duration: Duration(milliseconds: 600),
//                                         ),
//                                       );
//                                     },
//                                     child: const Text('Clear'))
//                               ],
//                             );
//                           });
//                     },
//                     child: const Text('Clear All')),
//               MostlyPlayedSongs(mostlydbsongs: mostlySongs)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MostlyPlayedSongs extends StatelessWidget {
//   final List<MostlyPlayed> mostlydbsongs;
//   MostlyPlayedSongs({super.key, required this.mostlydbsongs});

//   @override
//   Widget build(BuildContext context) {
//     final box = SongBox.getinstance();
//     return (mostlydbsongs.isEmpty)
//         ? Center(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.4),
//               child: const Text(
//                 "Empty !!! ",
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           )
//         : Padding(
//             padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
//             child: ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: mostlydbsongs.length,
//               itemBuilder: (context, index) {
//                 if (index == mostlydbsongs.length) {
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.08,
//                   );
//                 }
//                 MostlyPlayed currentSong = mostlydbsongs[index];
//                 return ListTile(
//                   tileColor: Colors.black,
//                   onTap: () {
//                     MostlyPlayed mostlySong;
//                     mostlySong = MostlyPlayed(
//                         title: currentSong.title,
//                         artist: currentSong.artist,
//                         duration: currentSong.duration,
//                         songurl: currentSong.songurl,
//                         id: currentSong.id,
//                         count: 1);

//                     addMostly(mostlySong);

//                     audioPlayers.open(
//                         Playlist(audios: convertMAudio, startIndex: index),
//                         showNotification: true,
//                         headPhoneStrategy:
//                             HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
//                         loopMode: LoopMode.playlist);

//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => NowPlaying(
//                               index: index,
//                               nowPlayList: mostlydbsongs,
//                             )));
//                   },
//                   leading: QueryArtworkWidget(
//                     artworkFit: BoxFit.cover,
//                     id: currentSong.id!,
//                     type: ArtworkType.AUDIO,
//                     artworkQuality: FilterQuality.high,
//                     size: 2000,
//                     quality: 100,
//                     artworkBorder: BorderRadius.circular(10),
//                     nullArtworkWidget: Container(
//                       width: MediaQuery.of(context).size.width * 0.134,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: AssetImage(
//                                 'assets/images/All_songs_logo.jpeg')),
//                       ),
//                     ),
//                   ),
//                   title: Text(
//                     currentSong.title!,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white),
//                   ),
//                   subtitle: currentSong.artist == '<unknown>'
//                       ? const Text(
//                           'Unknown Artist',
//                           style: TextStyle(fontSize: 14, color: Colors.white),
//                         )
//                       : Text(
//                           currentSong.artist!,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.white),
//                         ),
//                   trailing: PopupMenuButton(
//                     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//                       PopupMenuItem(
//                           child: TextButton(
//                         onPressed: () {
//                           addToFavorite(currentSong.id, context);
//                           Navigator.of(context).pop();
//                         },
//                         child: Text(isalready(currentSong.id)
//                             ? 'Remove from favourites'
//                             : 'Add to favourites'),
//                       )),
//                       PopupMenuItem(
//                         child: TextButton.icon(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             showBottomSheet(
//                               context: context,
//                               builder: (context) {
//                                 return SizedBox(
//                                   height: 100,
//                                   width: double.infinity,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           CreatePlaylist(
//                                                             song: currentSong,
//                                                           )));
//                                             },
//                                             child: const Text(
//                                                 'Create New Playlist')),
//                                       ),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text(
//                                                 'Add to existing Playlist')),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           icon: const Icon(Icons.playlist_add_outlined),
//                           label: const Text('Add to Playlist'),
//                         ),
//                       ),
//                     ],
//                     icon: const Icon(
//                       Icons.more_vert,
//                       color: Colors.white,
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => const Divider(height: 10),
//             ),
//           );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/mostly_controller.dart';
import 'package:music_app/view/screens/library/mostlyplayed/mostly_listtile.dart';

class MostlyPlayedScreen extends StatelessWidget {
  const MostlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MostlyPlayedController mostlyPlayedController =
        Get.put(MostlyPlayedController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Mostly Played',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          Obx(
            () => mostlyPlayedController.mostlySongs.isNotEmpty
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
                                  mostlyPlayedController
                                      .clearMostlyPlayedSongs();
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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: (mostlyPlayedController.mostlyplayeddbsong.isEmpty)
              ? const Center(
                  child: Text(
                    "You haven't played anything ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: mostlyPlayedController.mostlySongs.length,
                  itemBuilder: (context, index) {
                    if (index ==
                        mostlyPlayedController.mostlyplayeddbsong.length) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.005),
                      child: MostlyListView(
                        currentSong:
                            mostlyPlayedController.mostlyplayeddbsong[index],
                        convertAudios:
                            mostlyPlayedController.convertMostlyAudios,
                        index: index,
                      ),
                    );
                  },
                ),
        ),
      ),
      // MostlyListView(
      //   mostlydbsongs: mostlyPlayedController.mostlySongs,
      // ),
    );
  }
}
