import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/typedefs.dart';

class SwitchWidget extends StatelessWidget {

  final bool value;

  final SwitchTypedef onChanged;

  const SwitchWidget({
    super.key,
    required this.value,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Config.brandColor,
      inactiveTrackColor: Theme.of(context).colorScheme.primaryContainer,
      inactiveThumbColor: Config.brandColor.withOpacity(.4),
      splashRadius: 3,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      value: value,
      onChanged: onChanged
    );
  }
}
