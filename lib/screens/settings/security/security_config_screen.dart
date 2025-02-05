import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/settings_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPush, navigatorByPushNamed, navigatorByPop, showDialogWidget, showSnackBarWidget, toPersianNumber;
import 'package:invoice/screens/settings/security/security_passcode_form_screen.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/widgets/global/form/switch_widget.dart';

class SecurityConfigScreen extends StatefulWidget {

  const SecurityConfigScreen({super.key});

  @override
  State<SecurityConfigScreen> createState() => _SecurityConfigScreenState();
}

class _SecurityConfigScreenState extends State<SecurityConfigScreen> {

  void _showSnackBarError() => showSnackBarWidget(context, content: Text(t(context).error), duration: const Duration(seconds: 2), actionLabel: '');

  void _fingerprintHandler(bool value) {
    int intValue = value ? 1 : 0;
    SettingsTableSqliteDatabase().update({'fingerprint': intValue}).then((value) {
      getSecurityState(context, listen: false).changeFingerprint(intValue);
    }).catchError((error) {
      _showSnackBarError();
    });
  }

  void _disablePasscodeHandler() {
    showDialogWidget(context,
      content: Text(t(context).areYouSure(t(context).disablePasscode)),
      actions: [
        TextButton(
          child: Text(t(context).cancel),
          onPressed: () => navigatorByPop(context, result: false),
        ),
        const SizedBox(width: 20.0),
        TextButton(
          child: Text(t(context).disable),
          onPressed: () => navigatorByPop(context, result: true),
        )
      ]
    ).then((result) {
      if(result) {
        SettingsTableSqliteDatabase().update({'passcode': null, 'autoLockDuration': 0, 'fingerprint': 0, 'quantityOfAuthAttempts': 0}).then((value) {
          SecurityState securityState = getSecurityState(context, listen: false);
          securityState.changePasscode(null);
          securityState.changeAutoLockDuration(0);
          securityState.changeFingerprint(0);
          securityState.changeQuantityOfAuthAttempts(value: 0);
          navigatorByPop(context);
        }).catchError((error) {
          _showSnackBarError();
        });
      }
    });
  }

  String _getAutoLockDuration() {
    switch(getSecurityState(context).autoLockDuration) {
      case 0:
        return t(context).disable;
      case 60000:
        return "${t(context).within} ${toPersianNumber(context, '1', onlyConvert: true)} ${t(context).minutes}";
      case 300000:
        return "${t(context).within} ${toPersianNumber(context, '5', onlyConvert: true)} ${t(context).minutes}";
      case 3600000:
        return "${t(context).within} ${toPersianNumber(context, '1', onlyConvert: true)} ${t(context).hour}";
      default:
        return "${t(context).within} ${toPersianNumber(context, '5', onlyConvert: true)} ${t(context).hours}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).lockSettings, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            tileColor: Theme.of(context).cardColor,
            title: Text(t(context).lockConfigDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal)),
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: const Icon(Icons.lock_reset),
            title: Text(t(context).changePasscode),
            onTap: () => navigatorByPush(context, const SecurityPasscodeFormScreen(formMode: FormMode.update)),
          ),

          const Divider(endIndent: 20.0, indent: 20.0),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: const Icon(Icons.fingerprint),
            title: Text(t(context).unlockWithFingerprint),
            trailing: SwitchWidget(
              value: getSecurityState(context).fingerprint,
              onChanged: (bool value) => _fingerprintHandler(value)
            )
          ),

          const Divider(endIndent: 20.0, indent: 20.0),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: const Icon(Icons.lock_clock),
            title: Text(t(context).automaticLock),
            trailing: Opacity(opacity: .5, child: Text(_getAutoLockDuration(), style: Theme.of(context).textTheme.headlineSmall)),
            onTap: () => navigatorByPushNamed(context, '/settings/security/config/selectAutolockDuration')
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            tileColor: Theme.of(context).cardColor,
            title: Text(t(context).autoLockDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal)),
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: Icon(Icons.remove_circle_outline, color: Config.dangerColor),
            title: Text(t(context).disablePasscode, style: TextStyle(color: Config.dangerColor)),
            onTap: _disablePasscodeHandler,
          )
        ],
      ),
    );
  }
}
