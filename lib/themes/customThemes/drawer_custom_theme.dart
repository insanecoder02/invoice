import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class DrawerCustomTheme {
  static DrawerThemeData get light => DrawerThemeData(
    backgroundColor: Config.scaffoldColorLight,
    shape: const ContinuousRectangleBorder(),
  );
  
  static DrawerThemeData get dark => DrawerThemeData(
    backgroundColor: Config.scaffoldColorDark,
    shape: const ContinuousRectangleBorder(),
  );
}