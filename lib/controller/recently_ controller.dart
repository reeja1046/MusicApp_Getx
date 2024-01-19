// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:get/get.dart';
// import 'package:napster_project_getx/model/database/db_all_models.dart';
// import 'package:napster_project_getx/model/db_functions.dart';

// class RecentlyController extends GetxController {
//   var recentlyDbSongs = <RecentlyPlayed>[].obs;
//   var convertRecentlyAudios = <Audio>[].obs;
  

//   @override
//   void onInit() {
//     fetchAllSongs();
//     super.onInit();
//   }

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




//   void clearRecentlyPlayedSongs() {
//     recentlyPlayedBox.clear();
//     convertRecentlyAudios.clear();
//     recentlyDbSongs.clear();
//   }

//   void updateRecentlyPlayedSongs(RecentlyPlayed currentSong) async{
//     List<RecentlyPlayed> recentList = recentlyPlayedBox.values.toList();
//     bool isAlreadyAdded = recentList.where((song) => song.songname==currentSong.songname).isNotEmpty;
//     if(isAlreadyAdded){
//       int indexRecently = recentList.indexWhere((element) => element.songname==currentSong.songname);
//       await recentlyPlayedBox.deleteAt(indexRecently);
//       recentlyDbSongs.removeAt(indexRecently);
//       await recentlyPlayedBox.add(currentSong);
//       fetchAllSongs();
//     } else{
//       await recentlyPlayedBox.add(currentSong);
//       fetchAllSongs();
//     }
//   }
// }


