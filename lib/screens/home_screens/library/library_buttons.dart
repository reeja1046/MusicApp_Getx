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
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ));
  }
}
