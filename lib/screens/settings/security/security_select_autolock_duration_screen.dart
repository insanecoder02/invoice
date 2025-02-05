import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/database/sqlite/tables/settings_table_sqlite_database.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget, switchColor, toPersianNumber, navigatorByPop;

class SecuritySelectAutolockDurationScreen extends StatelessWidget {

  const SecuritySelectAutolockDurationScreen({super.key});

  void _changeAutoLockDuration(BuildContext context, int value) {
    SettingsTableSqliteDatabase().update({'autoLockDuration': value}).then((data) {
      SecurityState securityState = getSecurityState(context, listen: false);
      securityState.changeAutoLockDuration(value);
      navigatorByPop(context);
    }).catchError((error) {
      showSnackBarWidget(context, content: Text(t(context).error), duration: const Duration(seconds: 2), actionLabel: '');
      navigatorByPop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    int autoLockDuration = getSecurityState(context).autoLockDuration;

    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).automaticLock, style: Theme.of(context).textTheme.headlineLarge)
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            tileColor: Theme.of(context).cardColor,
            title: Text(t(context).autoLockDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal)),
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: autoLockDuration == 0 ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
            title: Text(t(context).disable, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)),
            onTap: () => _changeAutoLockDuration(context, 0),
          ),

          const Divider(endIndent: 20.0, indent: 20.0),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: autoLockDuration == 60000 ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
            title: Text("${t(context).within} ${toPersianNumber(context, '1', onlyConvert: true)} ${t(context).minutes}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)),
            onTap: () => _changeAutoLockDuration(context, 60000),
          ),

          const Divider(endIndent: 20.0, indent: 20.0),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: autoLockDuration == 300000 ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
            title: Text("${t(context).within} ${toPersianNumber(context, '5', onlyConvert: true)} ${t(context).minutes}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)),
            onTap: () => _changeAutoLockDuration(context, 300000),
          ),

          const Divider(endIndent: 20.0, indent: 20.0),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: autoLockDuration == 3600000 ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
            title: Text("${t(context).within} ${toPersianNumber(context, '1', onlyConvert: true)} ${t(context).hour}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)),
            onTap: () => _changeAutoLockDuration(context, 3600000),
          ),

          const Divider(endIndent: 20.0, indent: 20.0),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: autoLockDuration == 18000000 ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
            title: Text("${t(context).within} ${toPersianNumber(context, '5', onlyConvert: true)} ${t(context).hours}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)),
            onTap: () => _changeAutoLockDuration(context, 18000000),
          ),
        ]
      )
    );
  }
}
