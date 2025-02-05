import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, featuresAppWidget, navigatorByPushNamed, navigatorByPush;
import 'package:invoice/states/security_state.dart';
import 'package:invoice/screens/settings/security/security_passcode_form_screen.dart';

class SettingsScreen extends StatelessWidget {
  
  const SettingsScreen({super.key});

  void _redirectToSecuritySection(BuildContext context) {
    SecurityState securityState = getSecurityState(context, listen: false);
    if(securityState.passcode == null) {
      navigatorByPushNamed(context, '/settings/security');
    } else {
      navigatorByPush(context, const SecurityPasscodeFormScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    SecurityState securityState = getSecurityState(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).settings, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          featuresAppWidget(
            feature: FeaturesApp.multiLanguage,
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(t(context).language),
              trailing: Opacity(opacity: .5, child: Text(isRTL(context) ? 'فارسی' : 'English', style: Theme.of(context).textTheme.headlineSmall)),
              onTap: () => navigatorByPushNamed(context, '/settings/language')
            )
          ),
          const Divider(endIndent: 20.0, indent: 20.0),
          ListTile(
            leading: const Icon(Icons.lock_clock_rounded),
            title: Text(t(context).security),
            trailing: Opacity(opacity: .5, child: Text(securityState.passcode == null ? t(context).disable : t(context).enable, style: Theme.of(context).textTheme.headlineSmall)),
            onTap: () => _redirectToSecuritySection(context)
          )
        ],
      )
    );
  }
}
