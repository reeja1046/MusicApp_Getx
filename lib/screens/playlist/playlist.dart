import 'package:flutter/material.dart';
import 'package:music_app/database/functions/db_func.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/screens/playlist/playlist_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllPlaylist extends StatefulWidget {
  const AllPlaylist({super.key});

  @override
  State<AllPlaylist> createState() => _AllPlaylistState();
}

class _AllPlaylistState extends State<AllPlaylist> {
  String selectedItem = 'Remove';
  final playlistController = TextEditingController();
  final playlistAppbarController = TextEditingController();
  late List<PlayLists> allDbPlaylists;

  @override
  void initState() {
    allDbPlaylists = playlistdb.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allDbPlaylists = playlistdb.values.toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 30, 56),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Create New Playlist'),
                        content: GestureDetector(
                          child: TextField(
                            controller: playlistAppbarController,
                            cursorColor: Colors.black,
                            cursorHeight: 28,
                            onTap: () {},
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              prefixIcon: Icon(
                                Icons.playlist_add,
                                color: Colors.black,
                                size: 26,
                              ),
                              focusColor: Colors.black,
                              hintText: 'Enter the Name...',
                              hintStyle: TextStyle(color: Colors.black54),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                playlistAppbarController.clear();
                              },
                              child: const Text('Cancel')),
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: playlistAppbarController,
                            builder: (context, value, child) {
                              if (playlistAppbarController.text.isEmpty) {
                                return TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Please Enter a Name'),
                                          duration: Duration(milliseconds: 600),
                                        ),
                                      );
                                    },
                                    child: const Text('Create'));
                              } else {
                                return ElevatedButton(
                                    onPressed: (checkIfAlreadyExists(
                                            playlistAppbarController.text))
                                        ? () {
                                            playlistAppbarController.clear();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Playlist Already Exists'),
                                                duration:
                                                    Duration(milliseconds: 600),
                                              ),
                                            );
                                          }
                                        : () {
                                            playlistdb.add(PlayLists(
                                              playlistname:
                                                  playlistAppbarController.text,
                                              playlistsongs: [],
                                            ));
                                            playlistAppbarController.clear();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            Navigator.of(context).pop();
                                            setState(() {});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'New Playlist Created'),
                                                duration:
                                                    Duration(milliseconds: 800),
                                              ),
                                            );
                                          },
                                    child: const Text('Create'));
                              }
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.add,
                size: 28,
                color: Colors.white,
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          )
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 40.0, bottom: 8.0),
          child: Text(
            'Playlist',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
      body: (playlistdb.isEmpty)
          ? Center(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Empty Playlist",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    children: const [
                      Text(
                        'Your Playlists',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allDbPlaylists.length,
                    itemBuilder: (context, index) {
                      allDbPlaylists = playlistdb.values.toList();
                      final currentPlaylist = allDbPlaylists[index];
                      return ListTile(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EachPlaylistSongs(
                                      playlist: currentPlaylist)));
                          setState(() {});
                        },
                        leading: (currentPlaylist.playlistsongs!.isEmpty)
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/All_songs_logo.jpeg')),
                                ),
                              )
                            : QueryArtworkWidget(
                                artworkFit: BoxFit.cover,
                                id: currentPlaylist.playlistsongs!.first.id!,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                size: 2000,
                                quality: 100,
                                artworkBorder: BorderRadius.circular(10),
                                nullArtworkWidget: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.065,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/All_songs_logo.jpeg')),
                                  ),
                                ),
                              ),
                        title: Text(
                          currentPlaylist.playlistname!,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Text(
                          (currentPlaylist.playlistsongs!.length <= 1)
                              ? '${currentPlaylist.playlistsongs!.length.toString()} Song'
                              : '${currentPlaylist.playlistsongs!.length.toString()} Songs',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        trailing: PopupMenuButton<String>(
                          color: Colors.white,
                          padding: const EdgeInsets.all(1.0),
                          onSelected: (String value) {
                            setState(() {
                              selectedItem = value;
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: "Delete",
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Text(
                                                'Delete ${currentPlaylist.playlistname} Playlist'),
                                            content:
                                                const Text('Are You Sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text('Cancel')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    allDbPlaylists
                                                        .removeAt(index);
                                                    playlistdb.deleteAt(index);
                                                    setState(() {});
                                                    Navigator.of(ctx).pop();
                                                    ScaffoldMessenger.of(ctx)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Deleted from Playlists'),
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Delete'))
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(fontSize: 14))),
                            ),
                            PopupMenuItem<String>(
                              value: "Rename",
                              child: TextButton(
                                  onPressed: () {
                                    playlistController.text =
                                        currentPlaylist.playlistname!;
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Rename the Playlist'),
                                            content: GestureDetector(
                                              child: TextField(
                                                controller: playlistController,
                                                cursorColor: Colors.black,
                                                cursorHeight: 28,
                                                onTap: () {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.playlist_add,
                                                    color: Colors.black,
                                                    size: 26,
                                                  ),
                                                  focusColor: Colors.black,
                                                  hintText:
                                                      'Enter the New Name...',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Poppins'),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
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
                                              ValueListenableBuilder<
                                                  TextEditingValue>(
                                                valueListenable:
                                                    playlistController,
                                                builder:
                                                    (context, value, child) {
                                                  if (playlistController
                                                      .text.isEmpty) {
                                                    return TextButton(
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  'Please Enter a Name'),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      600),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            'Rename'));
                                                  } else {
                                                    return ElevatedButton(
                                                        onPressed:
                                                            (checkIfAlreadyExists(
                                                                    playlistController
                                                                        .text))
                                                                ? () {
                                                                    playlistController
                                                                        .clear();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Name Already Exists'),
                                                                        duration:
                                                                            Duration(milliseconds: 600),
                                                                      ),
                                                                    );
                                                                  }
                                                                : () {
                                                                    currentPlaylist
                                                                            .playlistname =
                                                                        playlistController
                                                                            .text;
                                                                    playlistdb.putAt(
                                                                        index,
                                                                        currentPlaylist);
                                                                    playlistController
                                                                        .clear();
                                                                    setState(
                                                                        () {});
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Playlist Renamed'),
                                                                        duration:
                                                                            Duration(milliseconds: 800),
                                                                      ),
                                                                    );
                                                                  },
                                                        child: const Text(
                                                            'Rename'));
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('Rename',
                                      style: TextStyle(fontSize: 14))),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
    );
  }

  bool checkIfAlreadyExists(String name) {
    bool isAlreadyAdded = allDbPlaylists
        .where((element) => element.playlistname == name.trim())
        .isNotEmpty;
    return isAlreadyAdded;
  }
}
