import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/database/model/song_model.dart';
import 'package:music_app/screens/home_screens/library/favourite_list.dart';
import 'package:music_app/screens/widgets/appbar_widget.dart';

import '../../../database/functions/db_func.dart';

class AddToFav extends StatefulWidget {
  const AddToFav({super.key});

  @override
  State<AddToFav> createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
late List<FavSongs> favitemsongs;
  @override
  void initState() {
   favitemsongs = favsongsdb.values.toList().reversed.toList();
    // TODO: implement initState
    super.initState();
  }

  final box = FavBox.getinstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ScreenAppbarWidget(title: 'Favorites',songList: favitemsongs,),
          Expanded(
            child: ValueListenableBuilder<Box<FavSongs>>(
                valueListenable: box.listenable(),
                builder: (context, Box<FavSongs> favouritesdb, child) {
                  List<FavSongs> favitemsongs =
                      favouritesdb.values.toList().reversed.toList();
                  return favitemsongs.isNotEmpty
                      ? ListView.separated(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          itemBuilder: (context, index) => Favouritelist(
                              song: favitemsongs[index],
                              songlist: favitemsongs,
                              index: index),
                          itemCount: favitemsongs.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.heart_broken_sharp,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            const Text(
                              "You haven't liked any Songs",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        );
                }),
          ),
        ],
      ),
    ),
    ),
    );
  }
}
