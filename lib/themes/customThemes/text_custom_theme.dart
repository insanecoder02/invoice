import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class TextCustomTheme {
  static TextTheme get light => TextTheme(
    headlineLarge: const TextStyle().copyWith(color: Config.foregroundLight, fontSize: Config.fontSizeLarg, fontWeight: FontWeight.bold),
    headlineMedium: const TextStyle().copyWith(color: Config.foregroundLight, fontSize: Config.fontSizeMedium, fontWeight: FontWeight.bold),
    headlineSmall: const TextStyle().copyWith(color: Config.foregroundLight.withOpacity(.5), fontSize: Config.fontSizeSmall, fontWeight: FontWeight.bold),
  );

  static TextTheme get dark => TextTheme(
    headlineLarge: const TextStyle().copyWith(color: Config.foregroundDark, fontSize: Config.fontSizeLarg, fontWeight: FontWeight.bold),
    headlineMedium: const TextStyle().copyWith(color: Config.foregroundDark, fontSize: Config.fontSizeMedium, fontWeight: FontWeight.bold),
    headlineSmall: const TextStyle().copyWith(color: Config.foregroundDark.withOpacity(.5), fontSize: Config.fontSizeSmall, fontWeight: FontWeight.normal),
  );
}