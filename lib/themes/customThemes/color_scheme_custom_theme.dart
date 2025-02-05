import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

///Theme.of(context).colorScheme.background------------->Switch between [scaffoldColorLight, scaffoldColorDark]
///Theme.of(context).colorScheme.primary---------------->Switch between [foregroundLight, foregroundDark]
///Theme.of(context).colorScheme.primaryContainer------->Switch between [backgroundLight, backgroundDark]

class ColorSchemeCustomTheme {
   static ColorScheme get light => ColorScheme.light(
    surfaceTint: Colors.transparent,
    outlineVariant: Config.foregroundLight.withOpacity(.1),
    surface: Config.backgroundLight,
    onSurface: Config.foregroundLight,
    error: Config.dangerColor.withOpacity(.5),

    //Switch Color
    background: Config.scaffoldColorLight,
    primary: Config.foregroundLight,
    primaryContainer: Config.backgroundLight,
  );

  static ColorScheme get dark => ColorScheme.dark(
    surfaceTint: Colors.transparent,
    outlineVariant: Config.foregroundLight.withOpacity(.1),
    surface: Config.backgroundDark,
    onSurface: Config.foregroundDark,
    error: Config.dangerColor.withOpacity(.5),

    //Switch Color
    background: Config.scaffoldColorDark,
    primary: Config.foregroundDark,
    primaryContainer: Config.backgroundDark
  );
}