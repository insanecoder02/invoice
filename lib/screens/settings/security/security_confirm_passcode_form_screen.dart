import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/settings_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPushReplacementNamed, navigatorByPop, toHash, showSnackBarWidget;
import 'package:invoice/states/security_state.dart';

class SecurityConfirmPasscodeFormScreen extends StatefulWidget {

  final String? passcode;

  final FormMode? formMode;

  const SecurityConfirmPasscodeFormScreen({this.passcode, this.formMode, super.key});

  @override
  State<SecurityConfirmPasscodeFormScreen> createState() => _SecurityConfirmPasscodeFormScreenState();
}

class _SecurityConfirmPasscodeFormScreenState extends State<SecurityConfirmPasscodeFormScreen> {

  final TextEditingController confirmPasscodeController = TextEditingController();

  String errorText = '';

  Timer? _timerToHide;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _cancelTimer() => _timerToHide != null && _timerToHide!.isActive ? _timerToHide!.cancel() : null;

  void _changeConfirmPasscode(String value) {
    if(value.length != 4) {
      setState(() => errorText = '');
      return;
    }

    if(value != widget.passcode) {
      setState(() => errorText = t(context).noMatchPasscode);
      confirmPasscodeController.text = '';

      _cancelTimer();
      _timerToHide = Timer(const Duration(milliseconds: 3000), () {
        setState(() => errorText = '');
        _timerToHide!.cancel();
      });

      return;
    }

    SettingsTableSqliteDatabase().update({'passcode': toHash(value)}).then((data) {
        SecurityState securityState = getSecurityState(context, listen: false);
        securityState.changePasscode(toHash(value));
        if(widget.formMode == FormMode.create) {
          navigatorByPushReplacementNamed(context, '/settings/security/config');
        } else {
          navigatorByPop(context);
        }
    }).catchError((error) {
      showSnackBarWidget(context, content: Text(t(context).error), duration: const Duration(seconds: 2), actionLabel: '');
      navigatorByPop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Icon(Icons.lock_clock_rounded, size: 80.0, color: Theme.of(context).colorScheme.primary),
          ),
          Text(t(context).reEnterYourPasscode, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Text(t(context).reEnterYourPasscodeDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1.8), textAlign: TextAlign.center),
          ),
          Theme(
            data: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.3))),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.3)))
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                controller: confirmPasscodeController,
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                maxLength: 4,
                style: TextStyle(fontSize: 30.0, letterSpacing: 7.0, color: Theme.of(context).colorScheme.primary),
                decoration: const InputDecoration(
                  counter: Offstage(),
                  contentPadding: EdgeInsets.zero
                ),
                onChanged: _changeConfirmPasscode,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(errorText, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal, color: Config.dangerColor.withOpacity(.7)), textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
