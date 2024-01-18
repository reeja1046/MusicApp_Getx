import 'package:flutter/material.dart';
import 'package:music_app/view/screens/searchscreen/search_screen.dart';

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
      backgroundColor: Colors.black,
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
