import 'dart:async';

import 'package:flutter/material.dart';
import 'package:informer/Screens/home_screen.dart';
import 'package:informer/Text%20Style/textstyle.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home_screen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/informer logo.png',
              height: sh / 3,
              width: sw / 3,
            ),
            Positioned(
              top: sh / 3.8,
              left: sw / 25,
              child: Text(
                'Informer',
                style: infromer_heading_style,
              ),
            )
          ],
        ),
      ),
    );
  }
}
