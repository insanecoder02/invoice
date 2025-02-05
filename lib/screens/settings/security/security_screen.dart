import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPushReplacement;
import 'package:invoice/widgets/global/form/button_widget.dart';
import 'package:invoice/screens/settings/security/security_passcode_form_screen.dart';

class SecurityScreen extends StatelessWidget {
  
  const SecurityScreen({super.key});

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
          Text(t(context).lockWithPasscode, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Text(t(context).lockWithPasscodeDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1.8), textAlign: TextAlign.center),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
        child: ButtonWidget(
          child: Text(t(context).enablePasscode),
          onPressed: () => navigatorByPushReplacement(context, const SecurityPasscodeFormScreen(formMode: FormMode.create))
        )
      )
    );
  }
}
