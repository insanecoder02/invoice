import 'dart:async';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/settings_table_sqlite_database.dart';
import 'package:invoice/plugins/local_auth_plugin.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/widgets/passcode/passcode_number_button_widget.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPop, navigatorByPushReplacementNamed, toHash, showSnackBarWidget;
import 'package:shared_preferences/shared_preferences.dart';

class PasscodeKeyboardWidget extends StatefulWidget {

  final bool fromSplash;

  final AnimationController animationController;

  const PasscodeKeyboardWidget(this.fromSplash, this.animationController, {super.key});

  @override
  State<PasscodeKeyboardWidget> createState() => _PasscodeKeyboardWidgetState();
}

class _PasscodeKeyboardWidgetState extends State<PasscodeKeyboardWidget> {

  Timer? _timerToHide;

  SupportState _supportState = SupportState.unknown;

  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    LocalAuthPlugin.isDeviceSupported().then((bool isSupported) => setState(() => _supportState = isSupported ? SupportState.supported : SupportState.unsupported));
  }

  @override
  void dispose() {
    _cancelTimerToHide();
    super.dispose();
  }

  void _cancelTimerToHide() => _timerToHide != null && _timerToHide!.isActive ? _timerToHide!.cancel() : null;

  void _showSnackBarError() => showSnackBarWidget(context, content: Text(t(context).error), duration: const Duration(seconds: 2), actionLabel: '');

  Future<void> _unverifiedPasscodeClear() {
    SecurityState securityState = getSecurityState(context, listen: false);
    securityState.changeUnverifiedPasscode('', asign: true);
    securityState.changeIsCheckingSecurity(false);
    
    return SettingsTableSqliteDatabase().update({'quantityOfAuthAttempts': 0}).then((data) {
      securityState.changeQuantityOfAuthAttempts(value: 0);
      securityState.changeIsInterruped(false);
    });
  }

  void _changeUnverifiedPasscode(String value, {bool asign = false, bool withTimer = true}) {
    SecurityState securityState = getSecurityState(context, listen: false);
    withTimer ? securityState.changeIsLastCharVisible(true) : null;
    securityState.changeUnverifiedPasscode(value, asign: asign);

    if(withTimer) {
      _cancelTimerToHide();
      _timerToHide = Timer(const Duration(milliseconds: 1500), () {
        securityState.changeIsLastCharVisible(false);
        _timerToHide!.cancel();
      });
    }
  }

  void _backspaceHandler(SecurityState securityState) {
    if(securityState.unverifiedPasscode.isNotEmpty) {
      _cancelTimerToHide();
      securityState.changeIsLastCharVisible(false);
      _changeUnverifiedPasscode(securityState.unverifiedPasscode.substring(0, securityState.unverifiedPasscode.length - 1), asign: true, withTimer: false);
    }
  }

  void _quantityOfAuthAttemptsHandler(SecurityState securityState) {
    if(securityState.unverifiedPasscode.length == 4) {

      SettingsTableSqliteDatabase().update({'quantityOfAuthAttempts': securityState.quantityOfAuthAttempts + 1}).then((data) {
        securityState.changeQuantityOfAuthAttempts();
        if(securityState.quantityOfAuthAttempts > 2) {
          SharedPreferences.getInstance().then((SharedPreferences prefs){
            securityState.changeIsInterruped(true);
            prefs.setInt('interruptionTime', DateTime.now().millisecondsSinceEpoch + ((securityState.quantityOfAuthAttempts - 2) * 5 * 1000) + 1000);
          });
        }
      }).catchError((error) {
        _showSnackBarError();  
      });

      _changeUnverifiedPasscode('', asign: true);
      widget.animationController.forward(from: 0).then((value) => widget.animationController.reverse().then((value) => widget.animationController.forward(from: 0).then((value) => widget.animationController.reverse())));
    }
  }

  void _letsGoToApp(SecurityState securityState) {
    _unverifiedPasscodeClear().then((data) {
      widget.fromSplash 
        ? navigatorByPushReplacementNamed(context, "/home")
        : navigatorByPop(context);
    }).catchError((error) {
      _showSnackBarError();
    });
  }

  dynamic _onPressedNumberButton(String value) {
    SecurityState securityState = getSecurityState(context, listen: false);

    if(value == "backspace") {
      _backspaceHandler(securityState);
      return;
    }

    if(securityState.unverifiedPasscode.length < 4) {
      _changeUnverifiedPasscode(value);
    }

    if(securityState.passcode != toHash(securityState.unverifiedPasscode)) {
      _quantityOfAuthAttemptsHandler(securityState);
      return;
    }
    
    _letsGoToApp(securityState);
  }

  Future<void> authenticateWithBiometrics(context) async {
    try {
      bool authenticated = await LocalAuthPlugin.authenticate(context);
      if(authenticated) {
        await _unverifiedPasscodeClear();
        widget.fromSplash
          ? navigatorByPushReplacementNamed(context, "/home")
          : navigatorByPop(context);
      }
    } catch(error) {
      _showSnackBarError();
    }
    /*if (!mounted) {return;}*/
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          PasscodeNumberButtonWidget(value: "1", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "2", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "3", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "4", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "5", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "6", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "7", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "8", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "9", onPressed: _onPressedNumberButton),

          if(_supportState == SupportState.supported)
          IconButton(
            icon: Icon(Icons.fingerprint, size: 35.0, color: Theme.of(context).colorScheme.primary.withOpacity(getSecurityState(context).fingerprint ? 1 : .2)),
            onPressed: () => getSecurityState(context, listen: false).fingerprint ? authenticateWithBiometrics(context) : null
          ),

          PasscodeNumberButtonWidget(value: "0", onPressed: _onPressedNumberButton),
          PasscodeNumberButtonWidget(value: "backspace", onPressed: _onPressedNumberButton)
        ],
      ),
    );
  }
}
