import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class BottomNavigationBarCustomTheme {
  static BottomNavigationBarThemeData get light => BottomNavigationBarThemeData(
    backgroundColor: Config.scaffoldColorLight,
    selectedItemColor: Config.foregroundLight,
    unselectedItemColor: Config.foregroundLight,
    elevation: 0,
  );
  
  static BottomNavigationBarThemeData get dark => BottomNavigationBarThemeData(
    backgroundColor: Config.scaffoldColorDark,
    selectedItemColor: Config.foregroundDark,
    unselectedItemColor: Config.foregroundDark,
    elevation: 0,
  );
}