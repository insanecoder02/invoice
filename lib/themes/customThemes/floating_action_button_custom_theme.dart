import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class FloatingActionButtonCustomTheme {
  static FloatingActionButtonThemeData get light => FloatingActionButtonThemeData(
    backgroundColor: Config.brandColor,
    foregroundColor: Colors.white,
  );
  
  static FloatingActionButtonThemeData get dark => FloatingActionButtonThemeData(
    backgroundColor: Config.brandColor,
    foregroundColor: Colors.white
  );
}