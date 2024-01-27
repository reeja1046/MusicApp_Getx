import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/model/database/db_func.dart';
import 'package:music_app/model/song_model/song_model.dart';

class FavoriteController extends GetxController {
  var convertFavSong = <Audio>[].obs;
  var favDbSongs = <FavSongs>[].obs;

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

  void fetchAllSongs() {
    favDbSongs.value = favsongsdb.values.toList();
    convertFavSong.clear();
    for (var element in favDbSongs) {
      convertFavSong.add(
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

  // void clearFavoriteSongs() {
  //   favDbSongs.clear();
  //   convertFavSong.clear();
  //   favsongsdb.clear();
  // }

  addToFavorite(int? id, BuildContext context) {
    final box = SongBox.getinstance();
    List<Song> dbSongs = box.values.toList();
    List<FavSongs> favoritesongs = favsongsdb.values.toList();
    bool isPresent = favoritesongs.any((element) => element.id == id);

    if (!isPresent) {
      Song song = dbSongs.firstWhere((element) => element.id == id);
      favsongsdb.add(FavSongs(
          title: song.title,
          artist: song.artist,
          duration: song.duration,
          songurl: song.songurl,
          id: song.id));

      const snackbar = SnackBar(
        content: Text(
          'Added to favorites',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        elevation: 70,
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      int favIndex = favoritesongs.indexWhere((element) => element.id == id);
      favsongsdb.deleteAt(favIndex);
      const snackbar = SnackBar(
        content: Text(
          'Removed from favorites',
          style:
              TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
        ),
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        elevation: 70,
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    fetchAllSongs();
  }

  bool isalready(id) {
    List<FavSongs> favouritesongs = [];
    favouritesongs = favsongsdb.values.toList();

    if (favouritesongs.any((element) => element.id == id)) {
      return true;
    } else {
      return false;
    }
  }

  removeFav(int? songid, BuildContext context) {
    int currentindex = favDbSongs.indexWhere((element) => element.id == songid);
    favsongsdb.deleteAt(currentindex);

    const snackbar = SnackBar(
      content: Text(
        'Removed from favourites',
        style: TextStyle(
            color: Color.fromARGB(255, 1, 30, 56), fontWeight: FontWeight.bold),
      ),
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      elevation: 70,
      duration: Duration(seconds: 1),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    fetchAllSongs();
  }
}
