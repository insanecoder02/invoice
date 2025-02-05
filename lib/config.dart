import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:pdf/pdf.dart' show PdfColor;

///Theme.of(context).colorScheme.background------------->Switch between [scaffoldColorLight, scaffoldColorDark]
///Theme.of(context).colorScheme.primary---------------->Switch between [foregroundLight, foregroundDark]
///Theme.of(context).colorScheme.primaryContainer------->Switch between [backgroundLight, backgroundDark]

class Config {

  static String get version => 'v1.0.0';

  static String get appName => 'invoice';

  static String get themeModeLable => 'theme_mode';
  
  static ThemeMode get themeMode => ThemeMode.light;

  static String get localeLable => 'locale';

  static Locale get locale => Locale.fa;
  
  static String get sqliteDb => 'invoice.db';

  static const sqliteSecretKey = "358GWqMgYkq0ZJx8";

  static const sqliteVersion = 1;

  static List<FeaturesApp> get features  => [
    FeaturesApp.multiLanguage,
    FeaturesApp.multiThemeMode,
  ];

  static Duration get splashAppDuration => const Duration(seconds: 8);

  //Brand Color
  static Color get brandColor => Colors.purple.shade700;

  static PdfColor get brandPdfColor => const PdfColor.fromInt(0xFF7B1FA2);

  //Scaffold Light
  static Color get scaffoldColorLight => Colors.white;

  //Scaffold Dark
  static Color get scaffoldColorDark => Colors.blueGrey.shade900;

  //AppBar Light
  static Color get appBarColorLight => Colors.white;
  
  //AppBar Dark
  static Color get appBarColorDark => Colors.blueGrey.shade900;

  //Foreground Color Light
  static Color get foregroundLight => Colors.blueGrey.shade700;

  //Foreground Color Dark
  static Color get foregroundDark => Colors.blueGrey.shade50;

  //Backgrround color Light
  static Color get backgroundLight => Colors.blueGrey.shade50;

  //Backgrround Color Dark
  static Color get backgroundDark => Colors.blueGrey.shade800;

  //Error Color
  static Color get dangerColor => Colors.red.shade700;

  //Border Radius
  static double get borderRadius => 15.0;

  //Width Border
  static double get widthBorder => 2.0;

  //Height Button
  static double get heightButton => 60.0;
  
  //Font Size
  static double get fontSizeLarg => 24.0;

  static double get fontSizeMedium=> 18.0;

  static double get fontSizeSmall => 14.0;

  static double get fontSizeExtraSmall => 12.0;

  //Icon Checkbox
  static IconData get iconChecked => Icons.check_circle;
  
  static IconData get iconUnChecked => Icons.circle_outlined;

  static int get baseInvoiceNumber => 2020;

}
