import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class CheckBoxWidget extends StatelessWidget {

  final bool isChecked;

  const CheckBoxWidget({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.square_rounded, size: isChecked ? 29.0 : 30.0, color: isChecked ? Colors.blueGrey.shade50 : Config.brandColor),
        if(isChecked)
        Icon(Icons.check_box, color: Config.brandColor, size: 30.0)
      ],
    );
  }
}
