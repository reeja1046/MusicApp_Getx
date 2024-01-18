import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/database/functions/db_func.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/view/widgets/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongAdapter());
  await Hive.openBox<Song>(boxname);

  Hive.registerAdapter(FavSongsAdapter());
  openFavDb();

  Hive.registerAdapter(RecentlyPlayedAdapter());
  openrecentplayedDB();

  Hive.registerAdapter(MostlyPlayedAdapter());
  openmostlyplayedDB();

  Hive.registerAdapter(PlayListAdapter());
  openplaylistDB();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
