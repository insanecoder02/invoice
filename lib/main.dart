import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invoice/plugins/bootstrap/bootstrap_plugin.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/states/setting_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/themes/core_theme.dart';
import 'package:provider/provider.dart';
import 'package:invoice/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
  ]).then((value) => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => SecurityState()),
        ChangeNotifierProvider(create: (BuildContext context) => SettingState()),
        ChangeNotifierProvider(create: (BuildContext context) => GlobalFormState()),
        ChangeNotifierProvider(create: (BuildContext context) => GlobalSearchState()),
        ChangeNotifierProvider(create: (BuildContext context) => CategoryState()),
        ChangeNotifierProvider(create: (BuildContext context) => ProductState()),
        ChangeNotifierProvider(create: (BuildContext context) => CustomerState()),
        ChangeNotifierProvider(create: (BuildContext context) => CustomerInvoicesState()),
        ChangeNotifierProvider(create: (BuildContext context) => InvoiceState()),
        ChangeNotifierProvider(create: (BuildContext context) => InvoiceProductsState()),
        ChangeNotifierProvider(create: (BuildContext context) => GlobalFormState())
      ],
      child: const MyApp(),
    )
  ));
}

class MyApp extends StatefulWidget {
  
  const MyApp({Key? key}):super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    BootstrapPlugin(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: getSettingState(context).title,
      debugShowCheckedModeBanner: false,
      themeMode: getSettingState(context).themeMode,
      theme: CoreTheme.light,
      darkTheme: CoreTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(getSettingState(context).locale.name),
      routes: routes,
    );
  }
}
