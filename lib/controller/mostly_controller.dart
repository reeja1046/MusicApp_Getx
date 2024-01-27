import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/model/database/db_func.dart';
import 'package:music_app/model/song_model/song_model.dart';

class MostlyPlayedController extends GetxController {
  var mostlyplayeddbsong = <MostlyPlayed>[].obs;
  var convertMostlyAudios = <Audio>[].obs;
  var mostlySongs = <MostlyPlayed>[].obs;

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

  void fetchAllSongs() {
    mostlyplayeddbsong.value = mostlyplayeddb.values.toList();
    mostlySongs.value =
        mostlyplayeddbsong.where((song) => song.count! > 5).toList();
    mostlySongs.sort((a, b) => b.count!.compareTo(a.count as num));
    convertMostlyAudios.clear();
    for (var element in mostlySongs) {
      convertMostlyAudios.add(
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

  void updateMostlyPlayedSongs(MostlyPlayed currentSong) async {
    bool isAlreadyAdded = mostlyplayeddbsong
        .where((song) => song.title == currentSong.title)
        .isNotEmpty;
    if (isAlreadyAdded) {
      int indexMostly = mostlyplayeddbsong
          .indexWhere((element) => element.title == currentSong.title);
      currentSong.count = (mostlyplayeddbsong[indexMostly].count! + 1);
      await mostlyplayeddb.putAt(indexMostly, currentSong);
      fetchAllSongs();
    } else {
      await mostlyplayeddb.add(currentSong);
      fetchAllSongs();
    }
  }

  void clearMostlyPlayedSongs() {
    mostlyplayeddbsong.clear();
    mostlyplayeddb.clear();
    mostlySongs.clear();
    convertMostlyAudios.clear();
  }
}
