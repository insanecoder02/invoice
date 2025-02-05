import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class PopupMenuCustomTheme {
  static PopupMenuThemeData get light => PopupMenuThemeData(
    color: Config.scaffoldColorLight,
    position: PopupMenuPosition.under,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0))
    ),
  );
  
  static PopupMenuThemeData get dark => PopupMenuThemeData(
    color: Config.backgroundDark,
    position: PopupMenuPosition.under,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0))
    ),
  );
}