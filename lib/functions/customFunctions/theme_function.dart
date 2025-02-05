import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/setting_state.dart';

ThemeMode finalTheme(BuildContext context) {
  ThemeMode themeMode = getSettingState(context).themeMode;
  
  if (themeMode == ThemeMode.system) {
    Brightness brightness = View.of(context).platformDispatcher.platformBrightness;
    themeMode = brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }

  return themeMode;
}

bool isThemeModeLight(BuildContext context) => finalTheme(context) == ThemeMode.light;

Color switchColor(BuildContext context, {Color? light, Color? dark}) {
  return isThemeModeLight(context) 
        ? light ?? Theme.of(context).colorScheme.background
        : dark  ?? Theme.of(context).colorScheme.primary;
}

TextStyle fontSizeTextStyle(BuildContext context, {required FontSize size, Color? color}) {
  return TextStyle(
    fontSize: size == FontSize.larg ? Config.fontSizeLarg : size == FontSize.medium ? Config.fontSizeMedium : size == FontSize.small ? Config.fontSizeSmall : Config.fontSizeExtraSmall,
    fontWeight: FontWeight.bold,
    color: color ?? Theme.of(context).colorScheme.primary
  );
}
