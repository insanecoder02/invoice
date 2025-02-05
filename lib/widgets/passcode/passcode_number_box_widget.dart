import 'package:flutter/material.dart';
import 'package:invoice/states/security_state.dart';

class PasscodeNumberBoxWidget extends StatelessWidget {

  const PasscodeNumberBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SecurityState securityState = getSecurityState(context);
    String unverifiedPasscode = securityState.unverifiedPasscode;

    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: securityState.isLastCharVisible
              ? Text(unverifiedPasscode.isNotEmpty ? unverifiedPasscode.substring(unverifiedPasscode.length - 1, unverifiedPasscode.length) : '', style: const TextStyle(letterSpacing: 10, fontSize: 30.0))
              : unverifiedPasscode.isNotEmpty 
                ? Icon(Icons.circle, size: 10.0, color: Theme.of(context).colorScheme.primary)
                : const Offstage()
          ),

          if(unverifiedPasscode.isNotEmpty)
          ...List.generate(unverifiedPasscode.length - 1, (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.circle, size: 10.0, color: Theme.of(context).colorScheme.primary),
          )),
        ],
      ),
    );
  }
}
