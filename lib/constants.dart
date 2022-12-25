import 'package:flutter/material.dart';

//----Colors-----
Color kBgColor = Color(0xff0062FE);
//----TextStyle---
TextStyle kSubTitleTextStyle = TextStyle(
    fontSize: 20, color: Color(0xff9FC8FA));
TextStyle kTitleTextStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Color(0xFFE4F5FF));
//---ButtonStyle---
ButtonStyle kButtonStyle = TextButton.styleFrom(
  padding: const EdgeInsets.all(16.0),
  primary: Color(0xff0062FE),
  backgroundColor: Colors.white,
  textStyle: const TextStyle(fontSize: 20),
);
ButtonStyle kButtonStyle2 = TextButton.styleFrom(

  padding: const EdgeInsets.all(16.0),
  primary: Color(0xff0062FE),
  // backgroundColor: Colors.white,
  textStyle: const TextStyle(fontSize: 20, ),
);
//----Borders----
double kImageBorder = 20;
//----Image Container Size---
double kImageWidth = 350;
double kImageHeight = 550;