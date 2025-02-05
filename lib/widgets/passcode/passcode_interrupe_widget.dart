import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber;
import 'package:invoice/states/security_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasscodeInterrupeWidget extends StatefulWidget {

  const PasscodeInterrupeWidget({super.key});

  @override
  State<PasscodeInterrupeWidget> createState() => _PasscodeInterrupeWidgetState();
}

class _PasscodeInterrupeWidgetState extends State<PasscodeInterrupeWidget> {

  int _cornometer = 0;

  @override
  void initState() {
    super.initState();
    _initialAndHandle();
  }

  void _initialAndHandle() {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      int interruptionTimeMilliseconds = prefs.getInt('interruptionTime')!;
      setState(() => _cornometer = ((interruptionTimeMilliseconds - DateTime.now().millisecondsSinceEpoch) / 1000).floor());
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() => _cornometer = ((interruptionTimeMilliseconds - DateTime.now().millisecondsSinceEpoch) / 1000).floor());
        if (DateTime.now().millisecondsSinceEpoch + 1000 > interruptionTimeMilliseconds) {
          SecurityState securityState = getSecurityState(context, listen: false);
          securityState.changeIsInterruped(false);
          securityState.changeUnverifiedPasscode('', asign: true);
          securityState.changeIsCheckingSecurity(false);
          _cornometer = 0;
          t.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(t(context).tooManyTries),
        const SizedBox(height: 10.0),
        Text(t(context).tooManyTriesCornometer(toPersianNumber(context, _cornometer.toString(), onlyConvert: true)))
      ],
    );
  }
}
