import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/database/model/song_model.dart';

class HomeController extends GetxController {
  var time = DateTime.now().obs;

  final box = SongBox.getinstance();
  var dbAllSongs = <Song>[].obs;
  var convertAllAudios = <Audio>[].obs;

  @override
  void onInit() async {
    await fetchAllSongs();
    super.onInit();
  }

  Future<void> fetchAllSongs() async {
    dbAllSongs.value = box.values.toList();

    for (var element in dbAllSongs) {
      convertAllAudios.add(
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
