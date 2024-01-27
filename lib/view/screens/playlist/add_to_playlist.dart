import 'package:flutter/material.dart';
import 'package:music_app/model/database/db_func.dart';
import 'package:music_app/model/song_model/song_model.dart';
import 'package:music_app/view/screens/playlist/create_playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddToPlaylists extends StatefulWidget {
  int songIndex;
  AddToPlaylists({super.key, required this.songIndex});

  @override
  State<AddToPlaylists> createState() => _AddToPlaylistsState();
}

class _AddToPlaylistsState extends State<AddToPlaylists> {
  List<PlayLists> allDbPlaylists = playlistdb.values.toList();
  final box = SongBox.getinstance();
  late List<Song> allDbSongs;

  @override
  void initState() {
    allDbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.height;
    return TextButton(
        onPressed: (playlistdb.isEmpty)
            ? () {
                Navigator.pop(context);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CreatePlaylist(song: allDbSongs[widget.songIndex]);
                    });
              }
            : () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: const Color.fromARGB(255, 14, 17, 42),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: allDbPlaylists.length,
                                //controller: controller,
                                itemBuilder: (context, index) => ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    List<Song> eachPlaylistSongs =
                                        allDbPlaylists[index]
                                            .playlistsongs!
                                            .toList();
                                    bool isAlreadyAdded = eachPlaylistSongs.any(
                                        (element) =>
                                            element.id ==
                                            allDbSongs[widget.songIndex].id);

                                    if (!isAlreadyAdded) {
                                      eachPlaylistSongs.add(Song(
                                          title: allDbSongs[widget.songIndex]
                                              .title,
                                          artist: allDbSongs[widget.songIndex]
                                              .artist,
                                          duration: allDbSongs[widget.songIndex]
                                              .duration,
                                          id: allDbSongs[widget.songIndex].id,
                                          songurl: allDbSongs[widget.songIndex]
                                              .songurl));
                                      playlistdb.putAt(
                                          index,
                                          PlayLists(
                                              playlistname:
                                                  allDbPlaylists[index]
                                                      .playlistname,
                                              playlistsongs:
                                                  eachPlaylistSongs));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Song Added to ${allDbPlaylists[index].playlistname}'),
                                          duration: const Duration(
                                              milliseconds: 1000),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Song Already Exist in ${allDbPlaylists[index].playlistname}'),
                                          duration: const Duration(
                                              milliseconds: 1000),
                                        ),
                                      );
                                    }
                                  },
                                  leading: (allDbPlaylists[index]
                                          .playlistsongs!
                                          .isEmpty)
                                      ? Container(
                                          width: widthDsp * 0.065,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/All_songs_logo.jpeg')),
                                          ),
                                        )
                                      : QueryArtworkWidget(
                                          artworkFit: BoxFit.cover,
                                          id: allDbPlaylists[index]
                                              .playlistsongs!
                                              .first
                                              .id!,
                                          type: ArtworkType.AUDIO,
                                          artworkQuality: FilterQuality.high,
                                          size: 2000,
                                          quality: 100,
                                          artworkBorder:
                                              BorderRadius.circular(10),
                                          nullArtworkWidget: Container(
                                            width: widthDsp * 0.065,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/images/All_songs_logo.jpeg')),
                                            ),
                                          ),
                                        ),
                                  title: Text(
                                    allDbPlaylists[index].playlistname!,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    (allDbPlaylists[index]
                                                .playlistsongs!
                                                .length <=
                                            1)
                                        ? '${allDbPlaylists[index].playlistsongs!.length.toString()} Song'
                                        : '${allDbPlaylists[index].playlistsongs!.length.toString()} Songs',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  trailing: const Icon(Icons.add_circle,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
        child: const Text("click here", style: TextStyle(fontSize: 14)));
  }
}
