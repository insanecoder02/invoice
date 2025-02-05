import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, toPersianNumber, navigatorByPushReplacement, navigatorByPushReplacementNamed, navigatorByPop, toHash, showDialogWidget;
import 'package:invoice/screens/settings/security/security_confirm_passcode_form_screen.dart';
import 'package:invoice/states/security_state.dart';

class SecurityPasscodeFormScreen extends StatefulWidget {

  final FormMode? formMode;

  const SecurityPasscodeFormScreen({this.formMode, super.key});

  @override
  State<SecurityPasscodeFormScreen> createState() => _SecurityPasscodeFormScreenState();
}

class _SecurityPasscodeFormScreenState extends State<SecurityPasscodeFormScreen> {

  final TextEditingController passcodeController = TextEditingController();

  String errorText = '';

  Timer? _timerToHide;
  
  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _cancelTimer() => _timerToHide != null && _timerToHide!.isActive ? _timerToHide!.cancel() : null;

  void _changePasscode(BuildContext context, String value) {
    if(value.length != 4) {
      setState(() => errorText = '');
      return;
    }
    
    if(widget.formMode != null) {
      navigatorByPushReplacement(context, SecurityConfirmPasscodeFormScreen(passcode: value, formMode: widget.formMode));
      return;
    }

    SecurityState securityState = getSecurityState(context, listen: false);
    if(toHash(value) == securityState.passcode) {
      navigatorByPushReplacementNamed(context, '/settings/security/config');
      return;
    }

    setState(() => errorText = t(context).passcodeInvalid);
    passcodeController.text = '';

    _cancelTimer();
    _timerToHide = Timer(const Duration(milliseconds: 3000), () {
      setState(() => errorText = '');
      _timerToHide!.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if(widget.formMode == null)
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showDialogWidget(
              context,
              alignment: Alignment.center,
              title: Text(t(context).forgotPasscode, style: Theme.of(context).textTheme.headlineMedium),
              content: Text(t(context).forgotPasscodeDescription),
              actionAlignment: MainAxisAlignment.end,
              actions: [
                TextButton(
                  child: Text(t(context).iUnderstand),
                  onPressed: () => navigatorByPop(context)
                )
              ]
            )
          ),
          SizedBox(width: isRTL(context) ? 5.0 : 10.0)
        ],
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Icon(Icons.lock_clock_rounded, size: 80.0, color: Theme.of(context).colorScheme.primary),
          ),
          Text(widget.formMode == FormMode.create ? t(context).createPasscode : widget.formMode == FormMode.update ? t(context).newPasscode : t(context).enterPasscode, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Text(widget.formMode != null ? t(context).passcodeDescription(toPersianNumber(context, '4', onlyConvert: true)) : t(context).enterYourPasscodeDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1.8), textAlign: TextAlign.center),
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
                controller: passcodeController,
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
                onChanged: (String value) => _changePasscode(context, value)
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
