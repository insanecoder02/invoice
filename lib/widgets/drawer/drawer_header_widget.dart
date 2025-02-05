import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/widgets/drawer/theme_mode_widget.dart';
import 'package:invoice/functions/core_function.dart' show featuresAppWidget, isThemeModeLight;

class DrawerHeaderWidget extends StatelessWidget {
  
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer
      ),
      child: Container(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image(image: AssetImage(isThemeModeLight(context) ? 'assets/images/invoice_name_light.png' : 'assets/images/invoice_name_dark.png'), width: 90)
            ),
            featuresAppWidget(
              feature: FeaturesApp.multiThemeMode,
              child: const ThemeModeWidget()
            )
          ],
        )
      )
    );
  }
}
