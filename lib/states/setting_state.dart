import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:provider/provider.dart';

class SettingState extends ChangeNotifier {
  
  String _title = Config.appName;

  Locale _locale = Config.locale;
  
  ThemeMode _themeMode = Config.themeMode;

  String get title => _title;

  Locale get locale => _locale;

  ThemeMode get themeMode => _themeMode;

  void changeTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void changeThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

SettingState getSettingState(BuildContext context, {bool listen = true}) => Provider.of<SettingState>(context, listen: listen);
