import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:music_app/database/functions/fav_db_functions.dart';
import 'package:music_app/screens/playlist/create_playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../database/model/song_model.dart';

class NowPlaying extends StatefulWidget {
  final int index;
  final List<dynamic> nowPlayList;
  const NowPlaying({
    super.key,
    required this.index,
    required this.nowPlayList,
  });

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class _NowPlayingState extends State<NowPlaying> {
  final box = SongBox.getinstance();
  late List<Song> allDbSongs;
  double progress = 0.0;
  bool isFavorite = false;

  @override
  void initState() {
    allDbSongs = box.values.toList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        return Scaffold(
          body: SafeArea(
            child: ValueListenableBuilder(
              valueListenable: scrollNotifier,
              builder: (context, value, child) {
                return NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    final ScrollDirection direction = notification.direction;
                    if (direction == ScrollDirection.reverse) {
                      scrollNotifier.value = false;
                    } else if (direction == ScrollDirection.forward) {
                      scrollNotifier.value = true;
                    }
                    return true;
                  },
                  child: PageView(
                    onPageChanged: (value) async {
                      (scrollNotifier.value)
                          ? await audioPlayer.previous()
                          : await audioPlayer.next();
                    },
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      widget.nowPlayList.length,
                      (index0) {
                        return Stack(
                          children: [
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: QueryArtworkWidget(
                                id: int.parse(playing.audio.audio.metas.id!),
                                type: ArtworkType.AUDIO,
                                size: 3000,
                                artworkFit: BoxFit.cover,
                                artworkBorder: BorderRadius.circular(10),
                                artworkQuality: FilterQuality.high,
                                nullArtworkWidget: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/All_songs_logo.jpeg'),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 1.0,
                                  width:
                                      MediaQuery.of(context).size.height * 1.0,
                                ),
                              ),
                            ),
                            Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.2),
                                      Colors.black.withOpacity(0.3),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.9),
                                      Colors.black.withOpacity(1),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppBar(
                                      leading: IconButton(
                                          onPressed: () async {
                                            await audioPlayer.pause();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.arrow_back)),
                                      backgroundColor: Colors.black,
                                      centerTitle: true,
                                      title: const Text(
                                        'Now Playing',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Marquee(
                                      animationDuration:
                                          const Duration(milliseconds: 6500),
                                      directionMarguee:
                                          DirectionMarguee.oneDirection,
                                      pauseDuration:
                                          const Duration(milliseconds: 1000),
                                      child: Text(
                                        audioPlayer.getCurrentAudioTitle,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Text(
                                      audioPlayer.getCurrentAudioArtist,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreatePlaylist(
                                                          song: allDbSongs[
                                                              widget.index]),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.playlist_add,
                                              color: Colors.white,
                                              size: 35,
                                            )),
                                        IconButton(
                                          onPressed: () async {
                                            (isalready(allDbSongs[widget.index]
                                                    .id))
                                                ? await removeFav(
                                                    allDbSongs[widget.index].id,
                                                    context)
                                                : await addToFavorite(
                                                    allDbSongs[widget.index].id,
                                                    context);
                                            setState(() {});
                                          },
                                          icon: (isalready(
                                                  allDbSongs[widget.index].id))
                                              ? const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                ),
                                          // Icon(
                                          //   isFavorite
                                          //       ? Icons.favorite
                                          //       : Icons.favorite_border,
                                          //   color: isFavorite
                                          //       ? Colors.red
                                          //       : Colors.white,
                                          // ),
                                          iconSize: 30,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: PlayerBuilder.realtimePlayingInfos(
                                        player: audioPlayer,
                                        builder:
                                            (context, realtimePlayingInfos) {
                                          final duration = realtimePlayingInfos
                                              .current!.audio.duration;
                                          final position = realtimePlayingInfos
                                              .currentPosition;
                                          return ProgressBar(
                                            progress: position,
                                            total: duration,
                                            timeLabelTextStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                            onSeek: (duration) {
                                              audioPlayer.seek(duration);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.shuffle,
                                              size: 30,
                                            ),
                                            color: Colors.white,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await audioPlayer.seekBy(
                                                const Duration(seconds: -10),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.replay_10,
                                              size: 30,
                                            ),
                                            color: Colors.white,
                                          ),
                                          PlayerBuilder.isPlaying(
                                            player: audioPlayer,
                                            builder: (context, isPlaying) {
                                              return IconButton(
                                                iconSize: 50,
                                                onPressed: () async {
                                                  await audioPlayer
                                                      .playOrPause();
                                                },
                                                icon: Icon(
                                                  (isPlaying)
                                                      ? Icons
                                                          .pause_circle_filled
                                                      : Icons.play_circle_fill,
                                                  size: 50,
                                                ),
                                                color: Colors.white,
                                              );
                                            },
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await audioPlayer.seekBy(
                                                const Duration(seconds: 10),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.forward_10,
                                              size: 30,
                                            ),
                                            color: Colors.white,
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.repeat,
                                              size: 30,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
