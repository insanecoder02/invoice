import 'package:flutter/material.dart';
import 'package:invoice/constans/typedefs.dart';

class PasscodeNumberButtonWidget extends StatelessWidget {

  final String value;

  final PasscodeNumberButtonTypedef? onPressed;
  
  const PasscodeNumberButtonWidget({
    super.key,
    required this.value, 
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:Container(
        alignment: Alignment.center,
        child: 
          value == "backspace"
            ? Icon(Icons.backspace, size: 25.0, color: Theme.of(context).colorScheme.primary)
            : Text(value, style: TextStyle(fontSize: 30.0, color: Theme.of(context).colorScheme.primary))
      ),
      onPressed: onPressed != null ? () => onPressed!(value) : null,
      iconSize: 50.0,
    );
  }
}
