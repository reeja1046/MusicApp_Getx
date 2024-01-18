import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/home_controller.dart';
import 'package:music_app/view/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    gotomain();
    homeController.fetchAllSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Seraphine',
                style: TextStyle(color: Colors.redAccent, fontSize: 40),
              ),
            ),
            Text(
              'Let music be your Soul',
              style: TextStyle(color: Colors.redAccent),
            )
          ],
        ),
      ),
    );
  }

  gotomain() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => BottomNavBar());
    });
  }
}
