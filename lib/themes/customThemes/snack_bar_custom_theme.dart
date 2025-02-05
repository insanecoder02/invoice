import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class SnackBarCustomTheme {
  static SnackBarThemeData get light => SnackBarThemeData(
    backgroundColor: Config.backgroundDark,
    actionTextColor: Config.foregroundDark,
    contentTextStyle: TextStyle(color: Config.foregroundDark, fontFamily: "Vazirmatn"),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0))
    ),
  );
  
  static SnackBarThemeData get dark => SnackBarThemeData(
    backgroundColor: Config.backgroundDark,
    actionTextColor: Config.foregroundDark,
    contentTextStyle: TextStyle(color: Config.foregroundDark, fontFamily: "Vazirmatn"),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0))
    ),
  );
}