import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class InputDecorationCustomTheme {
  static InputDecorationTheme get light => InputDecorationTheme(
    labelStyle: TextStyle(color: Config.foregroundLight.withOpacity(.6)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.foregroundLight.withOpacity(.3),
        width: Config.widthBorder
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.brandColor,
        width: Config.widthBorder
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.dangerColor,
        width: Config.widthBorder
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.dangerColor.withOpacity(.7),
        width: Config.widthBorder
      ),
    ),
    helperMaxLines: 3,
    helperStyle: TextStyle(
      color: Config.foregroundLight.withOpacity(.5),
      fontSize: Config.fontSizeExtraSmall
    ),
    errorMaxLines: 3,
    // prefixIconColor: 
    // suffixIconColor: 
  );
  
  static InputDecorationTheme get dark => InputDecorationTheme(
      labelStyle: TextStyle(color: Config.foregroundDark.withOpacity(.6)),
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.foregroundDark.withOpacity(.2),
        width: Config.widthBorder
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.brandColor,
        width: Config.widthBorder
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.dangerColor.withOpacity(.9),
        width: Config.widthBorder
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Config.borderRadius),
      borderSide: BorderSide(
        color: Config.dangerColor.withOpacity(.9),
        width: Config.widthBorder
      ),
    ),
    errorMaxLines: 3,
    // prefixIconColor: 
    // suffixIconColor: 
    helperMaxLines: 3,
    helperStyle: TextStyle(
      color: Config.foregroundDark.withOpacity(.5),
      fontSize: Config.fontSizeExtraSmall
    ),
  );
}