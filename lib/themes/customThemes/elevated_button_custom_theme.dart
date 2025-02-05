import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class ElevatedButtonCustomTheme {
  static ElevatedButtonThemeData get light => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Config.brandColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Config.brandColor.withOpacity(.5),
        disabledForegroundColor: Colors.white.withOpacity(.5),
        //side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.borderRadius),
        ),
        minimumSize: Size(double.infinity, Config.heightButton)
    )
  );

  static ElevatedButtonThemeData get dark => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Config.brandColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Config.brandColor.withOpacity(.5),
        disabledForegroundColor: Colors.white.withOpacity(.5),
        //side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.borderRadius),
        ),
        minimumSize: Size(double.infinity, Config.heightButton)
    )
  );
}