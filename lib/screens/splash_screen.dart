import 'dart:io';
import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/core_function.dart' show navigatorByPushReplacementNamed, navigatorByPushReplacement;
import 'package:invoice/screens/passcode_screen.dart';
import 'package:invoice/states/security_state.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Config.splashAppDuration);
    _animationController.forward().then((value) {
      SecurityState securityState = getSecurityState(context, listen: false);
      if (securityState.passcode == null && securityState.autoLockDuration == 0) {
        navigatorByPushReplacementNamed(context, '/home');
      } else {
        navigatorByPushReplacement(context, const PasscodeScreen(fromSplash: true));
      }
    }).catchError((error) => exit(0));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Center(
            child: Image(image: AssetImage('assets/images/invoice_icon.png'), width: 100)
            /*child: SplashAppAnimation(controller: _animationController.view, title: Config.appName)*/
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(Config.version, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal)),
                const SizedBox(height: 5.0),
                Text('From Pasalar', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal)),
              ],
            )
          )
        ],
      )
    );
  }
}
