import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/home_controller.dart';
import 'package:music_app/view/screens/homescreen/widgets/my_songs.dart';

class AllSongsList extends StatelessWidget {
  const AllSongsList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return (homeController.dbAllSongs.isEmpty)
        ? const Center(child: Text('No songs'))
        : Obx(
            () => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => MySong(
                index: index,
                currentSong: homeController.dbAllSongs[index],
                convertAudios: homeController.convertAllAudios,
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 10,
              ),
              itemCount: homeController.dbAllSongs.length,
            ),
          );
  }
}
