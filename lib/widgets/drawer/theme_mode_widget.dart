import 'package:flutter/material.dart';
import 'package:invoice/states/setting_state.dart';
import 'package:invoice/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoice/functions/core_function.dart' show t;

class ThemeModeWidget extends StatelessWidget {

  const ThemeModeWidget({super.key});

  void setThemeMode(BuildContext context, ThemeMode themeMode) {
    getSettingState(context, listen: false).changeThemeMode(themeMode);

    SharedPreferences.getInstance().then((SharedPreferences prefs){
      prefs.setString(Config.themeModeLable, themeMode.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = getSettingState(context).themeMode;
    switch(themeMode) {
      case ThemeMode.light:
        return Tooltip(
          message: t(context).switchToDarkMode,
          child: IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => setThemeMode(context, ThemeMode.dark)
          )
        );
      case ThemeMode.dark:
        return Tooltip(
          message: t(context).switchToSystemTheme,
          child: IconButton(
            icon: const Icon(Icons.incomplete_circle_sharp),
            onPressed: () => setThemeMode(context, ThemeMode.system)
          ),
        );
      default:
        return Tooltip(
          message: t(context).switchToLightMode,
          child: IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () => setThemeMode(context, ThemeMode.light)
          )
        );
    }
  }
}
