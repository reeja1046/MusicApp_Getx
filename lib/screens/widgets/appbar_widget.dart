import 'package:flutter/material.dart';
import 'package:music_app/screens/widgets/search_screen.dart';

import '../../database/model/song_model.dart';

class ScreenAppbarWidget extends StatelessWidget {
  final String title;
  final List<dynamic> songList;
  const ScreenAppbarWidget({
    super.key,
    required this.title,
    required this.songList,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 1, 30, 56),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    songList: songList,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search))
      ],
    );
  }
}
