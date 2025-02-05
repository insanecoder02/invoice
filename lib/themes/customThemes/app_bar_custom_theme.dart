import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class AppBarCustomTheme {
  static AppBarTheme get light => AppBarTheme(
    backgroundColor: Config.appBarColorLight,
    centerTitle: false,
    scrolledUnderElevation: 1.0,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(),
    titleTextStyle: const TextStyle(),
    actionsIconTheme: const IconThemeData()
  );
  
  static AppBarTheme get dark => AppBarTheme(
    backgroundColor: Config.appBarColorDark,
    centerTitle: false,
    scrolledUnderElevation: 1.0,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(),
    titleTextStyle: const TextStyle(),
    actionsIconTheme: const IconThemeData()
  );
}