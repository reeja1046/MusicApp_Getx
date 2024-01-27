import 'package:flutter/material.dart';
import 'package:music_app/model/song_model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<Song>> songListNotifier = ValueNotifier([]);

final audioQuery = OnAudioQuery();
final box = SongBox.getinstance();
List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];

Future<void> requestPermission() async {
  bool permissionstatus = await audioQuery.permissionsStatus();
  if (!permissionstatus) {
    await audioQuery.permissionsRequest();

    fetchSongs = await audioQuery.querySongs();
    for (var element in fetchSongs) {
      if (element.fileExtension == 'mp3') {
        allSongs.add(element);
      }
    }

    for (var element in allSongs) {
      await box.add(Song(
          title: element.title,
          artist: element.artist,
          duration: element.duration,
          songurl: element.uri,
          id: element.id));
    }
  }
}

// addRecently(RecentlyPlayed song) {
//   int index;
//   List<RecentlyPlayed> recentList = recentplayeddb.values.toList();
//   bool isnotavailable = recentList.where((element) {
//     return element.title == song.title;
//   }).isEmpty;
//   if (isnotavailable == true) {
//     recentplayeddb.add(song);
//   } else {
//     index = recentList.indexWhere((element) => element.title == song.title);
//     recentplayeddb.deleteAt(index);
//     recentplayeddb.add(song);
//   }
// }

// addMostly(MostlyPlayed song) {
//   List<MostlyPlayed> mostlyList = mostlyplayeddb.values.toList();
//   bool isNotPresent = mostlyList.where((element) {
//     return element.title == song.title;
//   }).isEmpty;
//   if (isNotPresent == true) {
//     mostlyplayeddb.add(song);
//   } else {
//     int index = mostlyList.indexWhere((element) => element.title == song.title);
//     int count = mostlyList[index].count!;
//     song.count = (count + 1);
//     mostlyplayeddb.deleteAt(index);
//     mostlyplayeddb.add(song);
//   }
// }
