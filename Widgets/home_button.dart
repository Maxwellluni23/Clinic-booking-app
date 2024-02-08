// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:dibrimak_mobile/Pages/home_page.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the home page when the button is pressed
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Icon(
          Icons.home_outlined,
          color: const Color.fromARGB(255, 53, 52, 52),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white60,
          shadowColor: Colors.grey,
        ),
      ),
    );
  }
}
