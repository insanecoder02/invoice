import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invoice/plugins/bootstrap/init_states_plugin.dart';

class BootstrapPlugin {

  final BuildContext context;

  late SharedPreferences _prefs;

  final List<FeaturesApp> _featuresApp = Config.features;

  final List<String> _listLocale = AppLocalizations.supportedLocales.map((l) => l.toString()).toList();

  final List<String> _listThemeMode = ThemeMode.values.map((t) => t.name).toList();

  BootstrapPlugin(this.context) {
    if (_featuresApp.isNotEmpty) {
      _handler();
    }
  }

  Future<void> _handler() async {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      _prefs = prefs;

      if (_featuresApp.contains(FeaturesApp.multiLanguage)) {
        _localeBoot();
      }

      if (_featuresApp.contains(FeaturesApp.multiThemeMode)) {
        _themeModeBoot();
      }
    });

    await InitStatesPlugin.initStates(context);
  }

  dynamic _localeBoot() {
    if(! _prefs.containsKey(Config.localeLable)) {
      return _prefs.setString(Config.localeLable, Locale.en.name);
    }

    String? localePrefs = _prefs.getString(Config.localeLable);

    if (_listLocale.contains(localePrefs)) {
      getSettingState(context, listen: false).changeLocale(localePrefs == Locale.en.name ? Locale.en : Locale.fa);
    }
  }

  dynamic _themeModeBoot() {
    if(! _prefs.containsKey(Config.themeModeLable)) {
      return _prefs.setString(Config.themeModeLable, ThemeMode.light.name);
    }

    String? themeModePrefs = _prefs.getString(Config.themeModeLable);

    if (_listThemeMode.contains(themeModePrefs)) {
      getSettingState(context, listen: false).changeThemeMode(themeModePrefs == ThemeMode.light.name ? ThemeMode.light : themeModePrefs == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.system);
    }
  }
}
