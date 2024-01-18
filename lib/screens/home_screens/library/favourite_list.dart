import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:music_app/database/functions/db_functions.dart';
import 'package:music_app/database/functions/fav_db_functions.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/screens/home_screens/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../widgets/main_play_screen.dart';

// ignore: must_be_immutable
class Favouritelist extends StatefulWidget {
  final FavSongs song;
  List<FavSongs> songlist;
  final Color? color;
  final int index;
  Favouritelist(
      {super.key,
      required this.song,
      required this.songlist,
      this.color,
      required this.index});

  @override
  State<Favouritelist> createState() => _FavouritelistState();
}

class _FavouritelistState extends State<Favouritelist> {
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.color ?? Colors.black,
      onTap: () {

 RecentlyPlayed recentlySong;
        recentlySong = RecentlyPlayed(
            title:   widget.song.title,
            artist:   widget.song.artist,
            duration:   widget.song.duration,
            songurl:   widget.song.songurl,
            id:   widget.song.id);

        MostlyPlayed mostlySong;
        mostlySong = MostlyPlayed(
            title:   widget.song.title,
            artist:   widget.song.artist,
            duration:   widget.song.duration,
            songurl:   widget.song.songurl,
            id:   widget.song.id,
            count: 1);
        addRecently(recentlySong);
        addMostly(mostlySong);

        audioPlayer.stop();
        audioList.clear();
        for (FavSongs item in widget.songlist) {
          audioList.add(Audio.file(item.songurl!,
              metas: Metas(
                title: item.title,
                artist: item.artist,
                id: item.id.toString(),
              )));
        }
        playingaudio(context, widget.index,widget.songlist);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      leading: QueryArtworkWidget(
        id: widget.song.id!,
        size: 3000,
        artworkFit: BoxFit.cover,
        type: ArtworkType.AUDIO,
        artworkBorder: BorderRadius.circular(10),
        artworkQuality: FilterQuality.high,
        nullArtworkWidget: Image(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
          image: const AssetImage(
            'assets/images/All_songs_logo.jpeg',
          ),
        ),
      ),
      title: Marquee(
        animationDuration: const Duration(milliseconds: 6500),
        directionMarguee: DirectionMarguee.oneDirection,
        pauseDuration: const Duration(milliseconds: 1000),
        child: Text(
          widget.song.title!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      subtitle: Text(widget.song.artist.toString(),
          style: const TextStyle(color: Colors.white)),
      trailing: IconButton(
          onPressed: () {
            // setState(() {});
            addToFavorite(widget.song.id, context);
          },
          icon: const Icon(Icons.delete, color: Colors.white)),
    );
  }
}

playingaudio(context, int index,songList) async {
  await audioPlayer.open(Playlist(audios: audioList, startIndex: index));
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NowPlaying(
            index: index,
            nowPlayList: songList,
          )));
}
