import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/themes/customThemes/app_bar_custom_theme.dart';
import 'package:invoice/themes/customThemes/bottom_navigation_bar_custom_theme.dart';
import 'package:invoice/themes/customThemes/drawer_custom_theme.dart';
import 'package:invoice/themes/customThemes/elevated_button_custom_theme.dart';
import 'package:invoice/themes/customThemes/color_scheme_custom_theme.dart';
import 'package:invoice/themes/customThemes/floating_action_button_custom_theme.dart';
import 'package:invoice/themes/customThemes/popup_menu_custom_theme.dart';
import 'package:invoice/themes/customThemes/snack_bar_custom_theme.dart';
import 'package:invoice/themes/customThemes/text_custom_theme.dart';
import 'package:invoice/themes/customThemes/input_decoration_custom_theme.dart';

class CoreTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Vazirmatn',
    colorScheme: ColorSchemeCustomTheme.light,
    // primaryColor: Config.primaryBgLight,
    textTheme: TextCustomTheme.light,
    scaffoldBackgroundColor: Config.scaffoldColorLight,
    drawerTheme: DrawerCustomTheme.light,
    elevatedButtonTheme: ElevatedButtonCustomTheme.light,
    cardColor: Config.backgroundLight,
    appBarTheme: AppBarCustomTheme.light,
    floatingActionButtonTheme: FloatingActionButtonCustomTheme.light,
    bottomNavigationBarTheme: BottomNavigationBarCustomTheme.light,
    dialogBackgroundColor: Config.scaffoldColorLight,
    snackBarTheme: SnackBarCustomTheme.light,
    popupMenuTheme: PopupMenuCustomTheme.light,
    indicatorColor: Config.foregroundLight,
    inputDecorationTheme: InputDecorationCustomTheme.light,
    buttonTheme: const ButtonThemeData(
      alignedDropdown: true
    )
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Vazirmatn',
    colorScheme: ColorSchemeCustomTheme.dark,
    // primaryColor: Config.primaryBgDark,
    textTheme: TextCustomTheme.dark,
    scaffoldBackgroundColor: Config.scaffoldColorDark,
    drawerTheme: DrawerCustomTheme.dark,
    elevatedButtonTheme: ElevatedButtonCustomTheme.light,
    cardColor: Config.backgroundDark,
    appBarTheme: AppBarCustomTheme.dark,
    floatingActionButtonTheme: FloatingActionButtonCustomTheme.dark,
    bottomNavigationBarTheme: BottomNavigationBarCustomTheme.dark,
    dialogBackgroundColor: Config.backgroundDark,
    snackBarTheme: SnackBarCustomTheme.dark,
    popupMenuTheme: PopupMenuCustomTheme.dark,
    indicatorColor: Config.foregroundDark,
    inputDecorationTheme: InputDecorationCustomTheme.dark,
    buttonTheme: const ButtonThemeData(
      alignedDropdown: true,
    )
  );
}