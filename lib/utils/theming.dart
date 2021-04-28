

import 'package:flutter/material.dart';

class AppColors {
  static Color mainPurple = Color(0xFF2E1963);
  static Color lightPurple = Color(0xFF7362A1);
  static Color purplePink = Color(0xFFE9BBFF);
  static Color white = Color(0xFFFFFFFF);
  static Color yellow = Color(0xFFFFC175);
  static Color chacoal = Color(0xFF3E0606);


  static LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF432B7B),
      Color(0xFF6A4BBC),
    ],
    stops: [0.9,0.9,],
  );

}