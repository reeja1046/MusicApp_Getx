import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/view/screens/settings/privacy_policy.dart';
import 'package:share_plus/share_plus.dart';

class MainSettings extends StatefulWidget {
  const MainSettings({super.key});

  @override
  State<MainSettings> createState() => _MainSettingsState();
}

class _MainSettingsState extends State<MainSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            ListTile(
              title: const Text(
                ' About Us ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 18,
              ),
              onTap: () {
                aboutUsPopUp();
              },
            ),
            ListTile(
              title: const Text(
                ' Privacy Policy ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 18,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy()));
              },
            ),
            ListTile(
              title: const Text(
                ' Share ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 18,
              ),
              onTap: () {
                Share.share('hai');
              },
            ),
            ListTile(
              title: const Text(
                ' Exit ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
                size: 25,
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  aboutUsPopUp() {
    final widthDsp = MediaQuery.of(context).size.width;
    final heightDsp = MediaQuery.of(context).size.height;
    showAboutDialog(
        context: context,
        applicationIcon: Container(
          height: heightDsp * 0.09,
          width: widthDsp * 0.18,
          decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/Chillax.png')),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        applicationName: "Seraphine",
        applicationVersion: '1.0.0',
        applicationLegalese: 'Copyright © 2023 Seraphine',
        children: [
          const Text(
              "Seraphine is an offline music player app which allows user to hear music from their storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
          SizedBox(
            height: heightDsp * 0.02,
          ),
          const Text("App developed by : \nReeja Grace Sabu.")
        ]);
  }
}
