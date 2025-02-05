import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPop;
import 'package:invoice/states/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  @override
  void initState() {
    super.initState();

    if(! Config.features.contains(FeaturesApp.multiLanguage)) {
      navigatorByPop(context);
    }
  }

  checkLocale(Locale locale) => getSettingState(context).locale == locale;

  void setLocale(BuildContext context, Locale locale) {
    getSettingState(context, listen: false).changeLocale(locale);
    
    SharedPreferences.getInstance().then((SharedPreferences prefs){
      prefs.setString(Config.localeLable, locale.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).selectLanguage, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          ListTile(
            title: const Text('English'),
            trailing: checkLocale(Locale.en) ? Icon(Icons.check, color: Config.brandColor, size: 30.0) : null,
            onTap: () => setLocale(context, Locale.en)
          ),
          const Divider(endIndent: 20.0, indent: 20.0),
          ListTile(
            title: const Text('فارسی'),
            trailing: checkLocale(Locale.fa) ? Icon(Icons.check, color: Config.brandColor, size: 30.0) : null,
            onTap: () => setLocale(context, Locale.fa)
          )
        ],
      )
    );
  }
}
