import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:invoice/functions/core_function.dart' show t;

class LocalAuthPlugin {

  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

   static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> cancelAuthentication() async {
    try {
      return await _auth.stopAuthentication();
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> authenticate(context) async {
    try {
      return await _auth.authenticate(
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: t(context).signInTitle,
            biometricHint: t(context).biometricHint,
            cancelButton: t(context).cancel
          ),
        ],
        localizedReason: t(context).fingerprintDescription,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true
        )
      );
    } on PlatformException {
      return false;
    }
  }
}
