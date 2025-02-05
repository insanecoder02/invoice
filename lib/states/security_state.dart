import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecurityState extends ChangeNotifier {

  bool _isCheckingSecurity = true;

  String? _passcode;

  int _autoLockDuration = 0, _fingerprint = 0, _quantityOfAuthAttempts = 0;

  bool get isCheckingSecurity => _isCheckingSecurity;

  String? get passcode => _passcode;

  int get autoLockDuration => _autoLockDuration;

  bool get fingerprint => _fingerprint == 1;

  int get quantityOfAuthAttempts => _quantityOfAuthAttempts;

  void changeIsCheckingSecurity(bool value) {
    _isCheckingSecurity = value;
    notifyListeners();
  }

  void changePasscode(String? value) {
    _passcode = value;
    notifyListeners();
  }

  void changeAutoLockDuration(int value) {
    _autoLockDuration = value;
    notifyListeners();
  }

  void changeFingerprint(int value) {
    _fingerprint = value;
    notifyListeners();
  }

  void changeQuantityOfAuthAttempts({int? value}) {
    value != null ? _quantityOfAuthAttempts = value : _quantityOfAuthAttempts++;
    notifyListeners();
  }

  //login

  String _unverifiedPasscode = '';

  bool _isLastCharVisible = true, _isInterruped = false;

  String get unverifiedPasscode => _unverifiedPasscode;

  bool get isLastCharVisible => _isLastCharVisible;

  bool get isInterruped => _isInterruped;

  void changeUnverifiedPasscode(String value, {bool asign = false}) {
    asign ? _unverifiedPasscode = value : _unverifiedPasscode += value;
    notifyListeners();
  }

  void changeIsLastCharVisible(bool value) {
    _isLastCharVisible = value;
    notifyListeners();
  }

  void changeIsInterruped(bool value) {
    _isInterruped = value;
    notifyListeners();
  }
}

SecurityState getSecurityState(BuildContext context, {bool listen = true}) => Provider.of<SecurityState>(context, listen: listen);
