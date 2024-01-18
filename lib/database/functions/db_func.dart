import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/database/model/song_model.dart';

late Box<FavSongs> favsongsdb;
openFavDb() async {
  favsongsdb = await Hive.openBox<FavSongs>('favorites');
}

late Box<RecentlyPlayed> recentplayeddb;
openrecentplayedDB() async {
  recentplayeddb = await Hive.openBox<RecentlyPlayed>('RecentlyPlayed');
}

late Box<MostlyPlayed> mostlyplayeddb;
openmostlyplayedDB() async {
  mostlyplayeddb = await Hive.openBox<MostlyPlayed>('MostlyPlayed');
}

late Box<PlayLists> playlistdb;
openplaylistDB() async{
 playlistdb= await Hive.openBox<PlayLists>('PlayList');
}
