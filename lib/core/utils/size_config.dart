import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? defultSize;
  static Orientation? orientation;
  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    orientation = MediaQuery.of(context).orientation;
    defultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
  }
}
