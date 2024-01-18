import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LibraryButtons extends StatelessWidget {
  String title;
  Widget onPressed;

  LibraryButtons({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => onPressed));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.42,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 2.5,
                  blurRadius: 5.5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage('assets/images/bg_image4.jpeg'),
                  fit: BoxFit.cover)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ));
  }
}
