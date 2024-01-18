import 'package:flutter/material.dart';
import 'package:music_app/database/functions/db_func.dart';
import 'package:music_app/database/model/song_model.dart';

class CreatePlaylist extends StatefulWidget {
  final dynamic song;
  CreatePlaylist({super.key, required this.song});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  final TextEditingController playlistController = TextEditingController();
  final box = SongBox.getinstance();
  late List<Song> allDbSongs;

  @override
  void initState() {
    allDbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Playlist'),
      content: GestureDetector(
        child: TextField(
          controller: playlistController,
          onChanged: (value) {},
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusColor: Colors.black,
            hintText: 'Enter the Name...',
            hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              playlistController.clear();
            },
            child: const Text('Cancel')),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: playlistController,
          builder: (context, value, child) {
            if (playlistController.text.isEmpty) {
              return TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please Enter a Name'),
                        duration: Duration(milliseconds: 600),
                      ),
                    );
                  },
                  child: const Text('Create'));
            } else {
              return ElevatedButton(
                  onPressed: (checkIfAlreadyExists(playlistController.text))
                      ? () {
                          playlistController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Playlist Already Exists'),
                              duration: Duration(milliseconds: 600),
                            ),
                          );
                        }
                      : () {
                          playlistdb.add(PlayLists(
                            playlistname: playlistController.text,
                            playlistsongs: [
                              Song(
                                  title: widget.song.title,
                                  artist: widget.song.artist,
                                  duration: widget.song.duration,
                                  id: widget.song.id,
                                  songurl: widget.song.songurl)
                            ],
                          ));
                          playlistController.clear();
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'New Playlist Created and the Song is Added.'),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                  child: const Text('Create'));
            }
          },
        ),
      ],
    );
  }

  bool checkIfAlreadyExists(String name) {
    List<PlayLists> allDbPlaylists = playlistdb.values.toList();
    bool isAlreadyAdded = allDbPlaylists
        .where((element) => element.playlistname == name.trim())
        .isNotEmpty;
    return isAlreadyAdded;
  }
}
