import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/widgets/passcode/passcode_header_widget.dart';
import 'package:invoice/widgets/passcode/passcode_keyboard_widget.dart';
import 'package:invoice/widgets/passcode/passcode_number_box_widget.dart';
import 'package:invoice/widgets/passcode/passcode_interrupe_widget.dart';

class PasscodeScreen extends StatefulWidget {

  final bool fromSplash;

  const PasscodeScreen({this.fromSplash = false, super.key});

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> with TickerProviderStateMixin {

  late AnimationController animationController;

  late Animation<Alignment> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    animation = Tween(begin: Alignment.center, end: Alignment.centerRight).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<bool> _willPopScopeHandler(BuildContext context) async {
    SecurityState securityState = getSecurityState(context, listen: false);
    securityState.changeUnverifiedPasscode('', asign: true);
    securityState.changeIsCheckingSecurity(true);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopScopeHandler(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20, bottom: 0),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              PasscodeHeaderWidget(animationController, animation),
              
              if(!getSecurityState(context).isInterruped)
                Column(
                  children: [
                    const PasscodeNumberBoxWidget(),
                    PasscodeKeyboardWidget(widget.fromSplash, animationController),
                  ],
                )
              else
                const PasscodeInterrupeWidget()
            ],
          ),
        )
      ),
    );
  }
}
