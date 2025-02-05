import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/typedefs.dart';
import 'package:invoice/functions/core_function.dart';

class InvoiceCardWidget extends StatelessWidget {
  
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? selected;
  final ListTileEventTypedef? onTap;
  final ListTileEventTypedef? onLongPress;

  const InvoiceCardWidget({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.selected,
    this.onTap,
    this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Config.borderRadius)),
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding: const EdgeInsets.all(0.0),
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title ?? const Offstage(),
                        const SizedBox(height: 10.0),
                        subtitle ?? const Offstage()
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        trailing ?? const Offstage()
                      ],
                    ),
                  )
                ]
              ),
            ),
            Positioned(
              top: 5.0, right: !isRTL(context) ? 12.0 : null, left: isRTL(context) ? 12.0 : null,
              child: selected ?? const Offstage()
            )
          ]
        )
      )
    );
  }
}
