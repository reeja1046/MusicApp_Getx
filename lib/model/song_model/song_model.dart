import 'package:hive_flutter/hive_flutter.dart';
part 'song_model.g.dart';

@HiveType(typeId: 0)
class Song {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;

  Song(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}

String boxname = 'Song';

class SongBox {
  static Box<Song>? _box;
  static Box<Song> getinstance() {
    return _box ??= Hive.box(boxname);
  }
}

@HiveType(typeId: 1)
class FavSongs {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;

  FavSongs(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}

// class FavBox {
//   static Box<FavSongs>? _box;
//   static Box<FavSongs> getinstance() {
//     return _box ??= Hive.box('favorites');
//   }
// }

@HiveType(typeId: 2)
class RecentlyPlayed {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;

  RecentlyPlayed(
      {this.title, this.artist, this.duration, this.songurl, required this.id});
}

class RecentlyPlayedBox {
  static Box<RecentlyPlayed>? _box;
  static Box<RecentlyPlayed> getinstance() {
    return _box ??= Hive.box('RecentlyPlayed');
  }
}

@HiveType(typeId: 3)
class MostlyPlayed {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  @HiveField(5)
  int? count;

  MostlyPlayed(
      {this.title,
      this.artist,
      this.duration,
      this.songurl,
      required this.id,
      required this.count});
}

class MostlyPlayedBox {
  static Box<MostlyPlayed>? _box;
  static Box<MostlyPlayed> getinstance() {
    return _box ??= Hive.box('MostlyPlayed');
  }
}

@HiveType(typeId : 4)
class PlayLists {
  @HiveField(0)
   String? playlistname;
  @HiveField(1)
  List<Song>? playlistsongs; 

  PlayLists(
    {required this.playlistname, 
    required this.playlistsongs});
}

