import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/database/functions/db_functions.dart';
import 'package:music_app/database/functions/fav_db_functions.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/view/screens/playlist/add_to_playlist.dart';
import 'package:music_app/view/screens/playlist/create_playlist.dart';
import 'package:music_app/view/widgets/main_play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  final List<dynamic> songList;
  const SearchScreen({
    super.key,
    required this.songList,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

class _SearchScreenState extends State<SearchScreen> {
  // List<Song> songList = Hive.box<Song>(boxname).values.toList();

  late List<dynamic> songDisplay = List<dynamic>.from(widget.songList);

  List<Audio> convertAudio = [];

  final textController = TextEditingController();
  @override
  void initState() {
    for (var element in songDisplay) {
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) => updateList(value),
              controller: textController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        textController.clear();
                        songDisplay = List<dynamic>.from(widget.songList);
                        setState(() {});
                      }),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: (songDisplay.isEmpty)
            ? Center(
                child: SizedBox(
                    height: size.height * 0.9,
                    width: size.width * 0.7,
                    child: Image.asset('assets/images/empty.png')),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: songDisplay.length,
                itemBuilder: (context, index) {
                  if (index == songDisplay.length) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    );
                  }
                  dynamic currentSong = songDisplay[index];
                  return ListTile(
                    
                    onTap: () {
                      RecentlyPlayed recentlySong;
                      recentlySong = RecentlyPlayed(
                          title: currentSong.title,
                          artist: currentSong.artist,
                          duration: currentSong.duration,
                          songurl: currentSong.songurl,
                          id: currentSong.id);

                      addRecently(recentlySong);

                      audioPlayer.open(
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
                                nowPlayList: songDisplay,
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
                          color: Colors.black),
                    ),
                    subtitle: currentSong.artist == '<unknown>'
                        ? const Text(
                            'Unknown Artist',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )
                        : Text(
                            currentSong.artist!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
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
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddToPlaylists(
                                                              songIndex:
                                                                  currentSong
                                                                      .id!,
                                                            )));
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
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  updateList(String value) {
    setState(() {
      songDisplay = widget.songList
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
    convertAudio.clear();
    for (var element in songDisplay) {
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
  }
}
