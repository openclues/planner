import 'package:flutter/material.dart';

class SizeSettings {
  static double? screenHeight;
  static double? screenWidth;
  static double? topPadding = kTextTabBarHeight;
  static double textMultiplier = 0.0;
  static double imageSizeMultiplier = 0.0;
  static double heightMultiplier = 0.0;
  static double widthMultiplier = 0.0;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    textMultiplier = screenHeight! * 0.01;
    imageSizeMultiplier = screenWidth! * 0.01;
    heightMultiplier = screenHeight! * 0.01;
    widthMultiplier = screenWidth! * 0.01;
  }
}
