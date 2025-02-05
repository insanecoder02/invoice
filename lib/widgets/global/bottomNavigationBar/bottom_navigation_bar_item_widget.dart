import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {

  final Icon icon;
  final String label;
  final bool mainItem;
  final void Function()? onPressed;

  const BottomNavigationBarItemWidget({
    super.key,
    required this.icon,
    this.label = '',
    this.mainItem = false,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70, height: 70,
      child: mainItem
        ? Center(
          child: Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: Config.brandColor,
              borderRadius: BorderRadius.circular(Config.borderRadius),
            ),
            child: icon,
          )
        )
        : IconButton(
          onPressed: onPressed,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              label.isNotEmpty
                ? FittedBox(
                    fit: BoxFit.contain,
                    child: Text(label)
                  )
                : const Offstage()
            ],
          ),
        )
    );
  }
}
