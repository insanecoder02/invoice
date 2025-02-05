import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/states/security_state.dart';

class PasscodeHeaderWidget extends StatelessWidget {

  final AnimationController animationController;

  final Animation<Alignment> animation;

  const PasscodeHeaderWidget(this.animationController, this.animation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Icon(Icons.lock, size: 50, color: Theme.of(context).colorScheme.primary),
        ),
        
        if(!getSecurityState(context).isInterruped)
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => Center(
              child: Container(
                width: 160,
                alignment: animation.value,
                child: Text(t(context).enterYourPasscode, style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
