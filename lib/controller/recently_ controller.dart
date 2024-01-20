import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/database/functions/db_func.dart';
import 'package:music_app/database/model/song_model.dart';


class RecentlyPlayedController extends GetxController{
var recentlyplayeddbsongs = <RecentlyPlayed>[].obs;
var convertRecentlyAudios = <Audio>[].obs;

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

Future<void> fetchAllSongs() async {
    recentlyplayeddbsongs.value = recentplayeddb.values.toList().reversed.toList();
convertRecentlyAudios.clear();
    for (var element in recentlyplayeddbsongs) {
      convertRecentlyAudios.add(
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

addRecently(RecentlyPlayed song) {
  int index;
  List<RecentlyPlayed> recentList = recentplayeddb.values.toList();
  bool isnotavailable = recentList.where((element) {
    return element.title == song.title;
  }).isEmpty;
  if (isnotavailable == true) {
    recentplayeddb.add(song);
  } else {
    index = recentList.indexWhere((element) => element.title == song.title);
    recentplayeddb.deleteAt(index);
    recentplayeddb.add(song);
  }
}

  void clearRecentlyPlayedSongs() {
    recentplayeddb.clear();
    convertRecentlyAudios.clear();
    recentlyplayeddbsongs.clear();
  }
  
}


