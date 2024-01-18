import 'package:flutter/material.dart';
import 'package:music_app/database/functions/db_functions.dart';
import 'package:music_app/view/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestPermission();
     gotomain();
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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    });
  }
}
